defmodule GameOfLife2.StateBuilder do
  use Agent

  @doc """
  Build the GenServer states from the cell values.
  this state {{1, 0, 1}, will give a list of GenServers.
              {1, 1, 1},
              {1, 0, 1}}
  """
  def build_state(state, result \\ [])
  def build_state([h | t], result) do
    res = List.insert_at(result, length(result), build_state_from_list(h))
    build_state(t, res)
  end
  def build_state([], result) do List.to_tuple(result) end

  @doc """
  Returns a tuple of GenServes pids.
  """
  def build_state_from_list(list, result \\ [])
  def build_state_from_list([h | t], result) do
    {:ok, pid} = build_state_from_value(h)
    res = List.insert_at(result, length(result), pid)
    build_state_from_list(t, res)
  end
  def build_state_from_list([], result) do List.to_tuple(result) end

  @doc """
  Returns a GenServes pid.
  """
  def build_state_from_value(v) do GameOfLife2.GolServer.start_link(v) end

end
