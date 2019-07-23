defmodule StateBuilderTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.StateBuilder

  require IEx

  test "build_state_from_value" do
    {:ok, pid} = GameOfLifeCore.StateBuilder.build_state_from_value(1)
    assert is_pid(pid)
  end

  test "build_state_line" do
    res = GameOfLifeCore.StateBuilder.build_state_line([1,0,1])
    assert res |> Tuple.to_list |> length == 3
    assert is_pid(elem(res, 1))
  end

  test "build_state" do
    state = [[1, 0, 0, 1],
             [1, 1, 0, 1],
             [1, 0, 0, 1]]
    res = GameOfLifeCore.StateBuilder.build_state(state)
    assert res |> Tuple.to_list |> length == 3
    assert is_tuple(res)
  end

  test "random_state_line" do
    res = GameOfLifeCore.StateBuilder.random_state_line(3)
    assert length(res) == 3
  end

  test "random_state" do
    res = [h | t] = GameOfLifeCore.StateBuilder.random_state(50,25)
    assert length(res) == 50
    assert length(h) == 25
  end

end
