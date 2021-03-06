defmodule GameOfLifeCore.List.StateTest do
  use ExUnit.Case

  alias GameOfLifeCore.List.State

  doctest GameOfLifeCore

  test "coordinates" do
    assert State.coordinates(5, 3, 3) == {2, 3}
    assert State.coordinates(0, 3, 3) == {1, 1}
    assert State.coordinates(8, 3, 3) == {3, 3}
  end

  test "position" do
    {line, col} = {5, 4}

    assert State.position(line, col, 1, 1) == 0
    assert State.position(line, col, 3, 3) == 10
    assert State.position(line, col, 5, 4) == 19
    assert State.position(line, col, 10, 10) == -1
  end

  test "get" do
    {state, line, col} = {[0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0], 5, 4}

    # Corners
    assert State.get(state, line, col, 1, 1) == 0
    assert State.get(state, line, col, 1, 4) == 0
    assert State.get(state, line, col, 5, 1) == 0
    assert State.get(state, line, col, 5, 4) == 0

    # Random values
    assert State.get(state, line, col, 3, 2) == 1
    assert State.get(state, line, col, 4, 3) == 1
    assert State.get(state, line, col, 2, 2) == 0
  end
end
