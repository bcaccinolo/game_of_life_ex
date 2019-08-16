defmodule GameOfLifeCore.Matrix2.Runner do
  @behaviour Interfaces.Runner

  alias GameOfLifeCore.Matrix2.{GolServer, StateBuilder, StateAgent}

  @doc """
  Build a random board and start the StateAgent server
  """
  def build_random_board(lines, cols) do
    StateBuilder.random_state(lines, cols)
    |> StateBuilder.build_state()
    |> StateAgent.start_link()
    {:ok}
  end

  @doc """
  Do the calculation for one cell iteration.
  No display is done
  """
  def one_generation do

    # takes nothing to do : 1.47e-4 sec
    board = StateAgent.state()
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    # (0..line_count - 1) |> Enum.each(fn line ->
    #   (0..col_count - 1) |> Enum.each(fn col ->
    #     # IO.puts("#{line} - #{col}")
    #   end)
    # end)

    # bundle = fn ->
    #   StateAgent.cell_and_env_list(board, line_count - 1, col_count - 1)
    # end
    # {ms, _} = :timer.tc(bundle)
    # IO.puts("Matrix2 #{ms / 1_000_000} sec")

    StateAgent.cell_and_env_list(board, line_count - 1, col_count - 1)
    |> Enum.map(fn {env, pid} ->
      Task.async(fn -> GolServer.calculate(pid, env) end)
    end)
    |> Enum.map(fn task -> Task.await(task) end)

    StateAgent.to_s()
  end
end
