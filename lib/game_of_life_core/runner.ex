defmodule GameOfLifeCore.Runner do

  def build_board(line, col) do
    GameOfLifeCore.StateBuilder.random_state(line, col)
    |> GameOfLifeCore.StateBuilder.build_state()
    |> GameOfLifeCore.StateAgent.start_link()
  end

  @doc """
  Display the board
  """
  def disp do
    board = GameOfLifeCore.StateAgent.state()
    line_count = board |> Tuple.to_list() |> length
    col_count = board |> elem(0) |> Tuple.to_list() |> length

    0..(line_count - 1)
    |> Enum.reduce("", fn line, acc -> "#{acc}\n#{build_line(elem(board, line), col_count)}" end)
  end

  @doc """
  Build a line to display from the board.
  Example:
    {1,1,0} => "++."
  """
  def build_line(board_line, col_count)
  def build_line(_board_line, 0), do: ""

  def build_line(board_line, col_count) do
    cell =
      elem(board_line, col_count - 1)
      |> GameOfLifeCore.GolServer.state()
      |> case do
        0 -> "."
        1 -> "+"
      end

    "#{build_line(board_line, col_count - 1)}#{cell}"
  end
end
