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
    {state, line, col} = StateAgent.state_and_dimensions()
    state_values = StateAgent.state_values()

    0..(line * col - 1)
    |> Enum.map(fn index ->
      pid = Enum.at(state, index)
      Task.async(fn -> do_it(pid, state_values, line, col, index) end) end)
    |> Enum.each(fn task -> Task.await(task) end)
  end

  def do_it(pid, state, line, col, index) do
    env = StateAgent.environment(state, line, col, index)
    GolServer.calculate(pid, env)
  end

  @doc """
  Return the board state in string format
  """
  def string_state do
    StateAgent.to_s()
  end
end
