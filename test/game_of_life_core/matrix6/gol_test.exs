defmodule GameOfLifeCore.Matrix6.GolTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Matrix6.Gol

  test "live_or_let_die(environment, x, y)" do
    a = {{1, 0, 0},
         {0, 1, 0},
         {0, 0, 0}}
    assert Gol.live_or_let_die(a, 1, 1) == 0

    a = {{1, 0, 1},
         {1, 1, 1},
         {1, 0, 1}}
    assert Gol.live_or_let_die(a, 1, 1) == 0

    a = {{1, 0, 0},
         {1, 1, 0},
         {1, 0, 0}}
    assert Gol.live_or_let_die(a, 1, 1) == 1

    a = {{1, 0, 0},
         {0, 0, 1},
         {0, 0, 1}}
    assert Gol.live_or_let_die(a, 1, 1) == 1

    a = {{1, 0, 0},
         {0, 0, 1},
         {0, 0, 0}}
    assert Gol.live_or_let_die(a, 1, 1) == 0

    a = {{1, 0, 0},
         {0, 1, 0},
         {1, 0, 0}}
    assert Gol.live_or_let_die(a, 1, 1) == 1
  end

  test "neighbours" do
    a = {{1, 0, 1},
         {1, 1, 1},
         {1, 0, 1}}
    assert Gol.neighbours(a, 1, 1) == 6
    b = {{1, 0},
         {1, 1},
         {1, 0}}
    assert Gol.neighbours(b, 1, 1) == 3
    assert Gol.neighbours(b, 1, 0) == 3
    c = {{1, 0},
         {1, 0}}
    assert Gol.neighbours(c, 1, 1) == 2
    assert Gol.neighbours(c, 0, 0) == 1
  end

  test "sumMatrix" do
    a = {{1, 0, 1},
         {1, 1, 1},
         {1, 0, 1}}
    assert Gol.sumMatrix(a) == 7
    b = {{1, 0},
         {1, 1},
         {1, 0}}
    assert Gol.sumMatrix(b) == 4
    c = {{1, 0},
         {1, 0}}
    assert Gol.sumMatrix(c) == 2
  end

  test "sumList" do
    assert Gol.sumList([1, 0, 0]) == 1
    assert Gol.sumList([1, 0, 1]) == 2
    assert Gol.sumList([1, 1, 1]) == 3
  end

end
