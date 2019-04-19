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
  def cell_and_environment(x, y) do
    board = Agent.get(__MODULE__, fn state -> state end)
    x_len = board |> Tuple.to_list |> length
    y_len = board |> elem(0) |> Tuple.to_list |> length

    {
      {
        { extact(board, x_len, y_len, x - 1, y - 1), extact(board, x_len, y_len, x - 1, y ), extact(board, x_len, y_len, x - 1, y + 1) },
        { extact(board, x_len, y_len, x, y - 1), extact(board, x_len, y_len, x, y), extact(board, x_len, y_len, x, y + 1) },
        { extact(board, x_len, y_len, x + 1, y - 1), extact(board, x_len, y_len, x + 1, y), extact(board, x_len, y_len, x + 1, y + 1) }
      },
      elem(elem(board, x), y)
    }

  end

  @doc """
  Extract just one cell value from the board
  """
  def extact(_board, _x_length, _y_length, x, _y) when x < 0 , do: 0
  def extact(_board, _x_length, _y_length, _x, y) when y < 0 , do: 0
  def extact(_board, x_length, _y_length, x, _y)  when x >= x_length , do: 0
  def extact(_board, _x_length, y_length, _x, y)  when y >= y_length , do: 0
  def extact(board, x_length, y_length, x, y) do
    elem(elem(board, x), y)
    |> GameOfLife2.GolServer.state
  end

  @doc """
  Update one cell

  Params
  x, y : coordinates of the cell in the board
  cell : the value of the cell (0 or 1)
  """
  def update_cell(x, y, cell) do
    board = Agent.get(__MODULE__, fn state -> state end)
    cell_server = elem(elem(board, x), y)
    GameOfLife2.GolServer.update(cell_server, cell)
  end

  @doc """
  Display the board
  """
  def disp do
    ExNcurses.clear()

    board = Agent.get(__MODULE__, fn state -> state end)
    y_len = board |> Tuple.to_list |> length
    x_len = board |> elem(0) |> Tuple.to_list |> length

    for x <- 0..(x_len - 1), y <- 0..(y_len - 1) do
      cell = elem(elem(board, x), y) |> GameOfLife2.GolServer.state
      case cell do
        0 -> ExNcurses.mvaddstr(x, y, "-" )
        1 -> ExNcurses.mvaddstr(x, y, "|" )
      end
    end

    ExNcurses.refresh()
  end

  def disp_board([h]) do
    Tuple.to_list(h) |> disp_list
  end
  def disp_board([h | t]) do
    Tuple.to_list(h) |> disp_list
    disp_board(t)
  end

  def disp_list([h]) do
    # GameOfLife2.GolServer.state(h) |> ExNcurses.mvaddstr(0, 2, "Snake")
  end
  def disp_list([h | t]) do
    # GameOfLife2.GolServer.state(h) |> ExNcurses.printw
    disp_list(t)
  end

end
