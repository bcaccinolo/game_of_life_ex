defmodule GameOfLife2.StateAgent do
  use Agent

  def start_link(initial_value) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  @doc """
  Return the all state.
  """
  def state do
    Agent.get(__MODULE__, fn state -> state end)
  end

  @doc """
  Get the cell state and the environment of the cell. Meaning the cell around it.
  Example:
          {{1, 0, 1},
           {1, 1, 1},
           {1, 0, 1}}
  """
  def cell_and_environment(line, col) do
    board = Agent.get(__MODULE__, fn state -> state end)
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    {
      {
        { extact(board, line_count, col_count, line - 1, col - 1), extact(board, line_count, col_count, line - 1, col ), extact(board, line_count, col_count, line - 1, col + 1) },
        { extact(board, line_count, col_count, line, col - 1), extact(board, line_count, col_count, line, col), extact(board, line_count, col_count, line, col + 1) },
        { extact(board, line_count, col_count, line + 1, col - 1), extact(board, line_count, col_count, line + 1, col), extact(board, line_count, col_count, line + 1, col + 1) }
      },
      elem(elem(board, line), col)
    }

  end

  @doc """
  Extract just one cell value from the board
  """
  def extact(_board, _line_count, _col_count, line, _col) when line < 0 , do: 0
  def extact(_board, _line_count, _col_count, _line, col) when col < 0 , do: 0
  def extact(_board, line_count, _col_count, line, _col)  when line >= line_count , do: 0
  def extact(_board, _line_count, col_count, _line, col)  when col >= col_count , do: 0
  def extact(board, _line_count, _col_count, line, col) do
    elem(elem(board, line), col)
    |> GameOfLife2.GolServer.state
  end

  @doc """
  Update one cell

  Params
  line, col : coordinates of the cell in the board
  cell : the value of the cell (0 or 1)
  """
  def update_cell(line, col, cell) do
    board = Agent.get(__MODULE__, fn state -> state end)
    cell_server = elem(elem(board, line), col)
    GameOfLife2.GolServer.update(cell_server, cell)
  end

  @doc """
  Display the board
  """
  def disp do
    board = Agent.get(__MODULE__, fn state -> state end)
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    # ExNcurses.mvaddstr(50, 30, "x is #{line_count}")
    # ExNcurses.mvaddstr(51, 30, "y is #{col_count}")

    for line <- 0..(line_count - 1) do
      ll = build_line(elem(board, line), col_count)
      ExNcurses.mvprintw(line, 0, ll)
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
           |> GameOfLife2.GolServer.state
           |> case do
             0 -> "."
             1 -> "+"
           end
    "#{build_line(board_line, col_count - 1)}#{cell}"
  end

end
