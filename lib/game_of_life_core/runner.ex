defmodule GameOfLifeCore.Runner do
  alias GameOfLifeCore.{StateAgent, StateBuilder, GolServer}

  @doc """
  Build a random board and start the StateAgent server
  """
  def build_random_board(line, col) do
    StateBuilder.random_state(line, col)
    |> StateAgent.start_link()
  end

  @doc """
  Do one Game of Life iteration on the existing state.
  It will create or remove cells.
  """
  def one_generation do
    {line, col} = StateAgent.dimensions()

    0..(line * col - 1)
    |> Enum.map(fn index -> StateAgent.environment_and_cell_by_index(index) end)
    |> Enum.map(fn {env, pid} -> Task.async(fn -> GolServer.calculate(pid, env) end) end)
    |> Enum.each(fn task -> Task.await(task) end)
  end

  @doc """
  Return the board state in string format
  """
  def string_state do
    StateAgent.to_s
  end
end
