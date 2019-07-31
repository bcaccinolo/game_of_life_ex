defmodule GameOfLifeCore.Matrix.StateAgent do
  use Agent

  alias GameOfLifeCore.Matrix.{GolServer, StateAgent}

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @doc """
  Return the complete state.
  """
  def state do
    Agent.get(__MODULE__, fn state -> state end)
  end

  @doc """
  Get the state and the environment of the cell present at line and col.
  Example:
    (3, 8) -> {{1, 0, 1},
               {1, 1, 1},
               {1, 0, 1}}
  """
  def cell_and_environment(line, col) do
    board = Agent.get(__MODULE__, fn state -> state end)
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length
    {
      {
        { extract(board, line_count, col_count, line - 1, col - 1), extract(board, line_count, col_count, line - 1, col ), extract(board, line_count, col_count, line - 1, col + 1) },
        { extract(board, line_count, col_count, line, col - 1)    , extract(board, line_count, col_count, line, col)     , extract(board, line_count, col_count, line, col + 1) },
        { extract(board, line_count, col_count, line + 1, col - 1), extract(board, line_count, col_count, line + 1, col) , extract(board, line_count, col_count, line + 1, col + 1) }
      },
      elem(elem(board, line), col)
    }
  end

  @doc """
  Extract just one cell value from the board
  """
  def extract(_board, _line_count, _col_count, line, _col) when line < 0 , do: 0
  def extract(_board, _line_count, _col_count, _line, col) when col < 0 , do: 0
  def extract(_board, line_count, _col_count, line, _col)  when line >= line_count , do: 0
  def extract(_board, _line_count, col_count, _line, col)  when col >= col_count , do: 0
  def extract(board, _line_count, _col_count, line, col) do
    elem(elem(board, line), col)
    |> GolServer.state
  end

  @doc """
  Build a 'cell_and_environment' list.
  It's done this way cause Elixir likes to manage list instead of Matrix.
  """
  def cell_and_env_list(line, col)
  def cell_and_env_list(0, col) , do: cell_and_env_line_list(0, col)
  def cell_and_env_list(line, col) do
    cell_and_env_line_list(line, col) ++ cell_and_env_list(line - 1, col)
  end

  @doc """
  Build a 'cell_and_environment' list just for one line of the matrix.
  """
  def cell_and_env_line_list(line, col)
  def cell_and_env_line_list(line, 0) , do: [StateAgent.cell_and_environment(line, 0)]
  def cell_and_env_line_list(line, col) do
    [StateAgent.cell_and_environment(line, col) | cell_and_env_line_list(line, col - 1)]
  end

  @doc """
  Update one cell

  Params
  line, col : coordinates of the cell in the board
  new_state : the value of the cell (0 or 1)
  """
  def update_cell(line, col, new_cell) do
    board = Agent.get(__MODULE__, fn state -> state end)
    cell_server = elem(elem(board, line), col)
    GolServer.update(cell_server, new_cell)
  end

  @doc """
  Display the board
  """
  def disp do
    board = Agent.get(__MODULE__, fn state -> state end)
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    ExNcurses.mvaddstr(line_count , 0, "Lines: #{line_count + 1} Cols: #{col_count + 1} GenServers: #{line_count * col_count}")

    for line <- 0..(line_count - 1) do
      cells_line = build_line(elem(board, line), col_count)
      ExNcurses.mvprintw(line, 0, cells_line)
      ExNcurses.refresh()
    end
  end

  @doc """
  Build a line to display from the board.
  Example:
    {1,1,0} => "++."
  """
  def build_line(board_line, col_count)
  def build_line(_board_line, 0) , do: ""
  def build_line(board_line, col_count) do
    cell = elem(board_line, col_count - 1)
           |> GolServer.state
           |> case do
             0 -> "."
             1 -> "+"
           end
    "#{build_line(board_line, col_count - 1)}#{cell}"
  end

end
