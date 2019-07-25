defmodule StateTest do
  use ExUnit.Case
  use GameOfLifeCore.State
  doctest GameOfLifeCore

  test "position" do
    {line, col} = {5, 4}

    assert GameOfLifeCore.State.position(line, col, 1, 1) == 0
    assert GameOfLifeCore.State.position(line, col, 3, 3) == 10
    assert GameOfLifeCore.State.position(line, col, 5, 4) == 19
    assert GameOfLifeCore.State.position(line, col, 10, 10) == -1
  end

  test "get" do
    {state, line, col} = {[0, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0], 5, 4}

    # Corners
    assert GameOfLifeCore.State.get(state, line, col, 1, 1) == 0
    assert GameOfLifeCore.State.get(state, line, col, 1, 4) == 0
    assert GameOfLifeCore.State.get(state, line, col, 5, 1) == 0
    assert GameOfLifeCore.State.get(state, line, col, 5, 4) == 0

    # Random values
    assert GameOfLifeCore.State.get(state, line, col, 3, 2) == 1
    assert GameOfLifeCore.State.get(state, line, col, 4, 3) == 1
    assert GameOfLifeCore.State.get(state, line, col, 2, 2) == 0
  end
end
