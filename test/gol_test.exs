defmodule GolTest do
  use ExUnit.Case
  use GameOfLife2.Gol
  doctest GameOfLife2

  test "live_or_let_die(environment, x, y)" do
    a = {{1, 0, 0},
         {0, 1, 0},
         {0, 0, 0}}
    assert live_or_let_die(a, 1, 1) == 0

    a = {{1, 0, 1},
         {1, 1, 1},
         {1, 0, 1}}
    assert live_or_let_die(a, 1, 1) == 0

    a = {{1, 0, 0},
         {1, 1, 0},
         {1, 0, 0}}
    assert live_or_let_die(a, 1, 1) == 1

    a = {{1, 0, 0},
         {0, 0, 1},
         {0, 0, 1}}
    assert live_or_let_die(a, 1, 1) == 1

    a = {{1, 0, 0},
         {0, 0, 1},
         {0, 0, 0}}
    assert live_or_let_die(a, 1, 1) == 0

    a = {{1, 0, 0},
         {0, 1, 0},
         {1, 0, 0}}
    assert live_or_let_die(a, 1, 1) == 1
  end

  test "neighbours" do
    a = {{1, 0, 1},
         {1, 1, 1},
         {1, 0, 1}}
    assert neighbours(a, 1, 1) == 6
    b = {{1, 0},
         {1, 1},
         {1, 0}}
    assert neighbours(b, 1, 1) == 3
    assert neighbours(b, 1, 0) == 3
    c = {{1, 0},
         {1, 0}}
    assert neighbours(c, 1, 1) == 2
    assert neighbours(c, 0, 0) == 1
  end

  test "sumMatrix" do
    a = {{1, 0, 1},
         {1, 1, 1},
         {1, 0, 1}}
    assert sumMatrix(a) == 7
    b = {{1, 0},
         {1, 1},
         {1, 0}}
    assert sumMatrix(b) == 4
    c = {{1, 0},
         {1, 0}}
    assert sumMatrix(c) == 2
  end

  test "sumList" do
    assert sumList([1, 0, 0]) == 1
    assert sumList([1, 0, 1]) == 2
    assert sumList([1, 1, 1]) == 3
  end

end
