defmodule GameOfLifeCore.Runner do
  alias GameOfLifeCore.{StateAgent, GolServer}

  @doc """
  Do one Game of Life iteration on the existing state.
  It will create or remove cells.
  """
  def one_generation do
    {line, col} = StateAgent.dimensions()
    Enum.each 1..(line * col), fn (index) -> one_generation_one_cell(index) end
  end

  @doc """
  Do one Game of Life iteration on one cell
  """
  def one_generation_one_cell(index) do
    StateAgent.environment_and_cell_by_index(index)
    |> Enum.map(fn {env, pid} -> Task.async(fn -> GolServer.calculate(pid, env) end) end)
    |> Enum.map(fn task -> Task.await(task) end)
  end

  @doc """
  Display the board
  """
  def disp do
    board = GameOfLifeCore.StateAgent.state()
    line_count = board |> Tuple.to_list() |> length
    col_count = board |> elem(0) |> Tuple.to_list() |> length

    0..(line_count - 1)

    # |> Enum.reduce("", fn line, acc -> "#{acc}\n#{build_line(elem(board, line), col_count)}" end)
  end
end
