defmodule GameOfLifeCore.List.StateBuilderTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.List.StateBuilder

  require IEx

  test "genserver_from_value" do
    pid = StateBuilder.genserver_from_value(1)
    assert is_pid(pid)
  end

  test "build_random_state" do
    {line, col} = {5, 2}
    state = StateBuilder.build_random_state(line, col)
    assert length(state) == line * col
  end

  test "random_state" do
    {line, col} = {5, 2}
    {state, returned_line, returned_col} = StateBuilder.random_state(line, col)
    assert length(state) == line * col
    assert returned_line == line
    assert returned_col == col

    [h | _t] = state
    assert is_pid(h)
  end
end
