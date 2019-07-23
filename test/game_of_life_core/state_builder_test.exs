defmodule StateBuilderTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.StateBuilder

  require IEx

  test "build_state_from_value" do
    {:ok, pid} = StateBuilder.build_state_from_value(1)
    assert is_pid(pid)
  end

  test "build_state_line" do
    res = StateBuilder.build_state_line([1,0,1])
    assert res |> Tuple.to_list |> length == 3
    assert is_pid(elem(res, 1))
  end

  test "build_state" do
    state = [[1, 0, 0, 1],
             [1, 1, 0, 1],
             [1, 0, 0, 1]]
    res = StateBuilder.build_state(state)
    assert res |> Tuple.to_list |> length == 3
    assert is_tuple(res)
  end

  test "random_state_line" do
    res = StateBuilder.random_state_line(3)
    assert length(res) == 3
  end

  test "random_state" do
    res = [h | _t] = StateBuilder.random_state(50,25)
    assert length(res) == 50
    assert length(h) == 25
  end

  test "build_random_state" do
    line = 50
    col = 25
    {state, l, c} = StateBuilder.build_random_state(line, col)

    [h | _t] = state |> Tuple.to_list

    assert state |> Tuple.to_list |> length == 50
    assert h |> Tuple.to_list |> length == 25

    assert line == l
    assert col == c
  end

end
