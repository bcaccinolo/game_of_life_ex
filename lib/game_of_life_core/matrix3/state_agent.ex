defmodule GameOfLifeCore.Matrix3.StateAgent do
  use Agent

  alias GameOfLifeCore.Matrix3.{GolServer, StateAgent}

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
  Retunr the values of the board state.
  """
  def state_values(state) do
    state |> Tuple.to_list |> Enum.map(fn line -> state_line_values(line) end) |> List.to_tuple
  end

  def state_line_values(state_line) do
    state_line |> Tuple.to_list |> Enum.map(fn pid -> pid |> GolServer.state end) |> List.to_tuple
  end

  @doc """
  Get the state and the environment of the cell present at line and col.
  Example:
    (3, 8) -> {{1, 0, 1},
               {1, 1, 1},
               {1, 0, 1}}
  """
  def cell_and_environment(board, line_count, col_count, line, col) do
    {
      { extract(board, line_count, col_count, line - 1, col - 1), extract(board, line_count, col_count, line - 1, col ), extract(board, line_count, col_count, line - 1, col + 1) },
      { extract(board, line_count, col_count, line, col - 1)    , extract(board, line_count, col_count, line, col)     , extract(board, line_count, col_count, line, col + 1) },
      { extract(board, line_count, col_count, line + 1, col - 1), extract(board, line_count, col_count, line + 1, col) , extract(board, line_count, col_count, line + 1, col + 1) }
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
    # |> GolServer.state
  end

  @doc """
  Build a String representation of the board.

  Example: "100\n110\n100"
  """
  def to_s do
    board = Agent.get(__MODULE__, fn state -> state end)
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    0..(line_count - 1)
    |> Enum.map(fn (line) ->  build_line(elem(board, line), col_count) end)
    |> Enum.join("\n")
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
    "#{build_line(board_line, col_count - 1)}#{cell}"
  end

end
