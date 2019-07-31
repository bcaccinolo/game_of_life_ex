defmodule GameOfLifeCore.StateBuilder do
  use Agent

  @doc """
  Build the GenServer states from the cell values.
  This state {{1, 0, 1}, will give a list of GenServers.
              {1, 1, 1},
              {1, 0, 1}}
  """
  def build_state(state, result \\ [])

  def build_state([h | t], result) do
    res = List.insert_at(result, length(result), build_state_from_list(h))
    build_state(t, res)
  end

  def build_state([], result), do: List.to_tuple(result)

  @doc """
  Returns a tuple of GenServes pids.
  """
  def build_state_from_list(list, result \\ [])

  def build_state_from_list([h | t], result) do
    {:ok, pid} = build_state_from_value(h)
    res = List.insert_at(result, length(result), pid)
    build_state_from_list(t, res)
  end

  def build_state_from_list([], result), do: List.to_tuple(result)

  @doc """
  Returns a GenServes pid.
  """
  def build_state_from_value(v) do
    GameOfLifeCore.GolServer.start_link(v)
  end

  @doc """
  Generate a random state to start the game of life.
  """
  def random_state(line_count, col_count)
  def random_state(0, _col_count), do: []
  def random_state(line_count, col_count),
    do: [random_list(col_count)] ++ random_state(line_count - 1, col_count)

  def random_list(len)
  def random_list(0), do: []
  def random_list(len), do: [:rand.uniform(2) - 1] ++ random_list(len - 1)
end
