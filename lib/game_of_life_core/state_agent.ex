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
  Return the pid from the state at an index
  """
  def state_at(_state, index) when index < 0, do: nil
  def state_at(state, index), do: Enum.at(state, index)

  @doc """
  Retunr the values of the board state.
  Example: [0, 1, 1, 0 ...]
  """
  def state_values do
    state() |> Enum.map(fn pid -> GolServer.state(pid) end)
  end

  @doc """
  Returns state's dimension: {line, col}
  """
  def dimensions do
    Agent.get(__MODULE__, fn {_state, line, col} -> {line, col} end)
  end

  @doc """
  Get the state and the environment of the cell present at line and col.

  Pararms
  state: list of values
  line, col: state's dimensions
  index: position of the cell to generate environment for

  Example:
    (3, 8) -> {[1, 0, 1, 1, 1, 1, 1, 0, 1], cell_pid}
  """
  def environment_and_cell(state, line, col, index) do # NOT USED ANY LONGER 💥
    {
      environment(state, line, col, index),
      Enum.at(state, index)
    }
  end

  @doc """
  Environment is the list of cells located around the cell at (cell_line, cell_col)

  Pararms
  state: list of values
  line, col: state's dimensions
  index: position of the cell to generate environment for

  Retunr example: [0, 1, 1, 1, 0, 1, 0, 0, 1]
  """
  # angle haut gauche
  def environment(state, _line, col, index) when index == 0 do
    [
      -1, -1, -1,
      -1, index, index + 1,
      -1, index + col, index + col + 1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end



  # angle haut droit
  def environment(state, _line, col, index) when index == col - 1 do
    [
      -1, -1, -1,
      index - 1, index, -1,
      index + col - 1, index + col, -1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # haut bordure
  def environment(state, _line, col, index) when index < col do
    [
      -1, -1, -1,
      index - 1, index, index + 1,
      index + col - 1, index + col, index + col + 1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # angle bas gauche
  def environment(state, line, col, index) when index == (line - 1) * col do
    [
      -1, index - col, index - col + 1,
      -1, index, index + 1,
      -1, -1, -1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # angle bas droit
  def environment(state, line, col, index) when index == line * col - 1 do
    [
      index - col - 1, index - col, -1,
      index - 1, index, -1,
      -1, -1, -1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # bas bordure
  def environment(state, line, col, index) when index > (line - 1) * col do
    [
      index - col - 1, index - col, index - col + 1,
      index - 1, index, index + 1,
      -1, -1, -1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # côté gauche mais pas tout en haut ni tout en bas
  def environment(state, _line, col, index) when rem(index, col) == 0 do
    [
      -1, index - col, index - col + 1,
      -1, index, index + 1,
      -1, index + col, index + col + 1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # côté droit mais pas tout en haut ni tout en bas
  def environment(state, _line, col, index) when rem(index + 1, col)  == 0 do
    [
      index - col - 1, index - col, -1,
      index - 1, index, -1,
      index + col - 1, index + col, -1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  # in the middle
  def environment(state, _line, col, index) do
    [
      index - col - 1, index - col, index - col + 1,
      index - 1, index, index + 1,
      index + col - 1, index + col, index + col + 1
    ]
    |> Enum.map(fn index -> Enum.at(state, index) end)
  end

  def cell(state, index) do
    Enum.at(state, index) |> GameOfLifeCore.GolServer.state()
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
    |> Enum.with_index()
    |> Enum.reduce("", fn {cell_state, index}, acc -> "#{acc}#{cell_to_s.(cell_state, index)}" end)
  end

  @doc """
  Used in 'to_s'
  Handle end of lines by adding '\n' at the end
  """
  def cell_value_to_s(line_length, cell_state, index) do
    case rem(index + 1, line_length) == 0 do
      true -> "#{cell_state}\n"
      _ -> "#{cell_state}"
    end
  end
end
