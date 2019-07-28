defmodule GameOfLifeCore.StateAgent do
  use Agent

  alias GameOfLifeCore.{GolServer, State}

  @doc """
  Start the Agent with a new state.
  The format of the state is {state, line, col}.

  Note: the state is a one dimension list.
  """
  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @doc """
  Returns the whole state {state, line, col}
  """
  def state_and_dimensions do
    Agent.get(__MODULE__, fn state -> state end)
  end

  @doc """
  Return the board state without dimensions
  """
  def state do
    Agent.get(__MODULE__, fn {state, _line, _col} -> state end)
  end

  @doc """
  Retunr the values of the board state.
  Example: [0, 1, 1, 0 ...]
  """
  def state_values do
    state() |> Enum.map(fn (pid) -> GolServer.state(pid) end)
  end

  @doc """
  Returns state's dimension: {line, col}
  """
  def dimensions do
    Agent.get(__MODULE__, fn {_state, line, col} -> {line, col} end)
  end


  def environment_and_cell_by_index(index) do
    {line, col} = dimensions()
    {cell_line, cell_col} = State.coordinates(index, line, col)
    environment_and_cell(cell_line, cell_col)
  end

  @doc """
  Get the state and the environment of the cell present at line and col.
  Example:
    (3, 8) -> {[1, 0, 1, 1, 1, 1, 1, 0, 1], cell_pid}
  """
  def environment_and_cell(cell_line, cell_col) do
    {state, line, col} = state_and_dimensions()

    {environment(state, line, col, cell_line, cell_col),
     cell(state, line, col, cell_line, cell_col)}
  end

  @doc """
  Environment is the list of cells located around the cell at (cell_line, cell_col)
  Example: [0, 1, 1, 1, 0, 1, 0, 0, 1]
  """
  def environment(state, line, col, cell_line, cell_col) do
    [
      {cell_line - 1, cell_col - 1},
      {cell_line - 1, cell_col},
      {cell_line - 1, cell_col + 1},
      {cell_line, cell_col - 1},
      {cell_line, cell_col},
      {cell_line, cell_col + 1},
      {cell_line + 1, cell_col - 1},
      {cell_line + 1, cell_col},
      {cell_line + 1, cell_col + 1}
    ]
    |> Enum.map(fn {x, y} -> GameOfLifeCore.State.get(state, line, col, x, y) end)
    |> Enum.map(fn pid -> GameOfLifeCore.GolServer.state(pid) end)
  end

  def cell(state, line, col, cell_line, cell_col) do
    GameOfLifeCore.State.get(state, line, col, cell_line, cell_col)
  end

  @doc """
  Update one cell

  Params
  cell_line, cell_col : coordinates of the cell in the board
  new_state : the value of the cell (0 or 1)
  """
  def update_cell(cell_line, cell_col, new_cell) do
    {state, line, col} = state_and_dimensions()

    GameOfLifeCore.State.get(state, line, col, cell_line, cell_col)
    |> GameOfLifeCore.GolServer.update(new_cell)
    |> case do
      {:error} -> {:error}
      _ -> {:ok}
    end
  end

  @doc """
  to string !
  Example: "100\n110\n100"
  """
  def to_s do
    {_line, col} = dimensions()
    # here I'm currying 'cell_value_to_s' cause I don't want to use the variable 'col' as a global var.
    cell_to_s = &cell_value_to_s(col, &1, &2)
    state_values()
    |> Enum.with_index
    |> Enum.reduce("", fn ({cell_state, index}, acc) ->  "#{acc}#{cell_to_s.(cell_state, index)}" end)
  end

  @doc """
  Used in 'to_s'
  Handle end of lines by adding '\n' at the end
  """
  def cell_value_to_s line_length, cell_state, index do
    case rem(index + 1, line_length) == 0 do
       true -> "#{cell_state}\n"
        _ -> "#{cell_state}"
    end
  end

end
