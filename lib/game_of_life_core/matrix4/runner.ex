defmodule GameOfLifeCore.Matrix4.Runner do
  @behaviour Interfaces.Runner

  alias GameOfLifeCore.Matrix4.{GolServer, StateBuilder, StateAgent}

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
    board_values = StateAgent.state_values(board)
    line_count = board |> Tuple.to_list() |> length
    col_count = board |> elem(0) |> Tuple.to_list() |> length

    Enum.flat_map(0..(line_count - 1), fn line ->
      Enum.map(0..(col_count - 1), fn col ->
        {env, pid} = { StateAgent.cell_and_environment(board_values, line_count, col_count, line, col) , elem(elem(board, line), col) }
        GolServer.calculate(pid, env)
      end)
    end)

    StateAgent.to_s()
  end
end
