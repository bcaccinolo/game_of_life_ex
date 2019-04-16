defmodule StateBuilderTest do
  use ExUnit.Case
  doctest GameOfLife2

  require IEx

  test "build_state_from_value" do
    {:ok, pid} = GameOfLife2.StateBuilder.build_state_from_value(1)
    assert is_pid(pid)
  end

  test "build_state_from_list" do
    res = GameOfLife2.StateBuilder.build_state_from_list([1,0,1])
    assert length(Tuple.to_list(res)) == 3
    assert is_pid(elem(res, 1))
  end

  test "build_state" do
    state = [[1, 0, 0],
             [1, 1, 0],
             [1, 0, 0]]
    res = GameOfLife2.StateBuilder.build_state(state)
    assert length(Tuple.to_list(res)) == 3
    assert is_tuple(res)
  end

  test "random_list" do
    res = GameOfLife2.StateBuilder.random_list(3)
    assert length(res) == 3
  end

  test "random_state" do
    res = GameOfLife2.StateBuilder.random_state(5,5)
    assert length(res) == 5
  end

end
