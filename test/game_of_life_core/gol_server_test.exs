defmodule GolServerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  test "state" do
     {:ok, pid} = GameOfLifeCore.GolServer.start_link(1)
     assert GameOfLifeCore.GolServer.state(pid) == 1

     {:ok, pid} = GameOfLifeCore.GolServer.start_link(0)
     assert GameOfLifeCore.GolServer.state(pid) == 0
  end

  test "update" do
     {:ok, pid} = GameOfLifeCore.GolServer.start_link(1)
     assert GameOfLifeCore.GolServer.state(pid) == 1

     GameOfLifeCore.GolServer.update(pid, 0)
     assert GameOfLifeCore.GolServer.state(pid) == 0
  end

  test "calculate" do
     {:ok, pid} = GameOfLifeCore.GolServer.start_link(0)

     a = {{1, 0, 0},
          {1, 1, 0},
          {1, 0, 0}}
     assert GameOfLifeCore.GolServer.calculate(pid, a, 1, 1) == 1
     assert GameOfLifeCore.GolServer.state(pid) == 1

     a = {{1, 0},
          {1, 0}}
     assert GameOfLifeCore.GolServer.calculate(pid, a, 1, 1) == 0
     assert GameOfLifeCore.GolServer.state(pid) == 0
  end

end
