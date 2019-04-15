defmodule GolServerTest do
  use ExUnit.Case
  doctest GameOfLife2

  test "state" do
     {:ok, pid} = GameOfLife2.GolServer.start_link(1)
     assert GameOfLife2.GolServer.state(pid) == 1

     {:ok, pid} = GameOfLife2.GolServer.start_link(0)
     assert GameOfLife2.GolServer.state(pid) == 0
  end

  test "update" do
     {:ok, pid} = GameOfLife2.GolServer.start_link(1)
     assert GameOfLife2.GolServer.state(pid) == 1

     GameOfLife2.GolServer.update(pid, 0)
     assert GameOfLife2.GolServer.state(pid) == 0
  end

  test "calculate" do
     {:ok, pid} = GameOfLife2.GolServer.start_link(0)

     a = {{1, 0, 0},
          {1, 1, 0},
          {1, 0, 0}}
     assert GameOfLife2.GolServer.calculate(pid, a, 1, 1) == 1
     assert GameOfLife2.GolServer.state(pid) == 1

     a = {{1, 0},
          {1, 0}}
     assert GameOfLife2.GolServer.calculate(pid, a, 1, 1) == 0
     assert GameOfLife2.GolServer.state(pid) == 0
  end

end
