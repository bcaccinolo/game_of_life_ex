defmodule GameOfLifeCore.StateBuilder do
  use Agent

  @doc """
  Generate a random state.

  Returns a tuple {random_state, line, column}
  """
  def generate_random_list(line, column) do
    {random_state(line, column), line, column}
  end

  @doc """
  Generate a random state to start the game of life.

  Returns: {cell_state, line, column}
  """
  def random_state(0, _col_count), do: []

  def random_state(line_count, col_count),
    do: [random_state_line(col_count)] ++ random_state(line_count - 1, col_count)

  @doc """
  Generate a random line. Used by random_state.

  Returns [0, 1, 1, ...]
  """
  def random_state_line(0), do: []

  def random_state_line(len), do: [:rand.uniform(2) - 1] ++ random_state_line(len - 1)

  @doc """
  Build the GenServer states from the cell values.
  This state {{1, 0, 1}, will give a list of GenServers.
              {1, 1, 1},
              {1, 0, 1}}

  Returns an array (a tuple of tuples) of GenServers
  """
  def build_state(state, result \\ [])

  def build_state([h | t], result) do
    res = List.insert_at(result, length(result), build_state_line(h))
    build_state(t, res)
  end

  def build_state([], result), do: List.to_tuple(result)

  @doc """
  Returns a tuple of GenServes pids representing one line.
  """
  def build_state_line(list, result \\ [])

  def build_state_line([h | t], result) do
    {:ok, pid} = build_state_from_value(h)
    res = List.insert_at(result, length(result), pid)
    build_state_line(t, res)
  end

  def build_state_line([], result), do: List.to_tuple(result)

  @doc """
  Starts a GenServer to handle a new cell.

  Returns a GenServer's pid
  """
  def build_state_from_value(v) do
    GameOfLifeCore.GolServer.start_link(v)
  end
end
