defmodule GameOfLifeCore.List.GolServerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.List.GolServer

  test "state" do
     {:ok, pid} = GolServer.start_link(1)
     assert GolServer.state(pid) == 1

     {:ok, pid} = GolServer.start_link(0)
     assert GolServer.state(pid) == 0
  end

  test "calculate" do
     {:ok, pid} = GolServer.start_link(0)

     a = [1, 0, 0,1, 1, 0,1, 0, 0]
     assert GolServer.calculate(pid, a, 1, 1) == 1
     assert GolServer.state(pid) == 1
  end

end
