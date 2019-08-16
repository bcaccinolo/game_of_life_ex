defmodule GameOfLifeCore.Matrix.Runner do
  @behaviour Interfaces.Runner

  alias GameOfLifeCore.Matrix.{GolServer, StateBuilder, StateAgent}

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
    board = StateAgent.state()
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    StateAgent.cell_and_env_list(line_count - 1, col_count - 1)
    |> Enum.map(fn {env, pid} ->
      Task.async(fn -> GolServer.calculate(pid, env) end)
    end)
    |> Enum.map(fn task -> Task.await(task) end)

    StateAgent.to_s()
  end
end
