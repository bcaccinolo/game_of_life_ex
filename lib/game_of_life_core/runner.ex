defmodule GameOfLifeCore.Runner do
  alias GameOfLifeCore.{StateAgent, GolServer}

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
end
