defmodule GameOfLifeCore.Runner do
  alias GameOfLifeCore.{StateAgent, GolServer}

  @doc """
  Do one Game of Life iteration on the existing state.
  It will create or remove cells.
  """
  def one_generation do
    {line, col} = StateAgent.dimensions()
    Enum.each(1..(line * col), fn index -> one_generation_one_cell(index) end)
  end

  @doc """
  Do one Game of Life iteration on one cell
  """
  def one_generation_one_cell(index) do
    StateAgent.environment_and_cell_by_index(index)
    |> Enum.map(fn {env, pid} -> Task.async(fn -> GolServer.calculate(pid, env) end) end)
    |> Enum.map(fn task -> Task.await(task) end)
  end
end
