defmodule GameOfLifeCore.List.Runner do

  alias GameOfLifeCore.List.{StateAgent, StateBuilder, GolServer}

  @doc """
  Build a random board and start the StateAgent server
  """
  def build_random_board(line, col) do
    {state, line, col} = StateBuilder.random_state(line, col)
    StateAgent.start_link({state, line, col})
    state
  end

  @doc """
  Do one Game of Life iteration on the existing state.
  It will create or remove cells.

  Returns the state in string format.
  """
  def one_generation do
    {state, line, col} = StateAgent.state_and_dimensions()
    state_values = StateAgent.state_values(state)

    0..(line * col - 1)
    |> Stream.map(fn index ->
      pid = Enum.at(state, index)
      Task.async(fn -> one_generation_cell(pid, state_values, line, col, index) end)
    end)
    |> Enum.map(fn task -> Task.await(task) end)

    StateAgent.to_s(state)
  end

  def one_generation_cell(pid, state, line, col, index) do
    env = StateAgent.environment(state, line, col, index)
    GolServer.calculate(pid, env)
    {:ok}
  end
end
