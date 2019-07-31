defmodule GolTest do
  use ExUnit.Case
  alias GameOfLifeCore.Gol
  doctest GameOfLifeCore

  test "live_or_let_die(environment)" do
    a = [1, 0, 0, 0, 1, 0, 0, 0, 0]
    assert Gol.live_or_let_die(a) == 0

    a = [1, 0, 1, 1, 1, 1, 1, 0, 1]
    assert Gol.live_or_let_die(a) == 0

    a = [1, 0, 0, 1, 1, 0, 1, 0, 0]
    assert Gol.live_or_let_die(a) == 1

    a = [1, 0, 0, 0, 0, 1, 0, 0, 1]
    assert Gol.live_or_let_die(a) == 1

    a = [1, 0, 0, 0, 0, 1, 0, 0, 0]
    assert Gol.live_or_let_die(a) == 0

    a = [1, 0, 0, 0, 1, 0, 1, 0, 0]
    assert Gol.live_or_let_die(a) == 1
  end

  test "neighbours" do
    a = [1, 0, 1, 1, 1, 1, 1, 0, 1]
    assert Gol.neighbours(a) == 6
  end

  test "sumMatrix" do
    a = [1, 0, 1, 1, 1, 1, 1, 0, 1]
    assert Gol.sumMatrix(a) == 7
  end

end
