defmodule GameOfLifeCore.List.StateBuilder do
  use Agent

  alias GameOfLifeCore.List.{GolServer}

  @doc """
  Generate a random state of GenServers.

  Note: the state is a one dimension list

  Returns a tuple {random_state, line, column}
  """
  def random_state(line, column) do
    {build_random_state(line, column) |> build_genserver_state, line, column}
  end

  @doc """
  Generate a random state to start the game of life.

  Note: the state is a one dimension list [0, 1, 1, 0, ...]

  Returns: the state list
  """
  def build_random_state(line, col) do
    1..(line * col)
    |> Enum.map(fn _ -> :rand.uniform(2) - 1 end)
  end

  @doc """
  Returns a list of GenServers representing the state.
  """
  def build_genserver_state(state) do
    state
    |> Enum.map(fn cell -> genserver_from_value(cell) end)
  end

  @doc """
  Starts a GenServer to handle a new cell.

  Returns a GenServer's pid
  """
  def genserver_from_value(v) do
    {:ok, pid} = GolServer.start_link(v)
    pid
  end
end
