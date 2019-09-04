defmodule GameOfLifeCore.Matrix5.GolServerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Matrix5.{GolServer}

  test "state" do
    {:ok, pid} = GolServer.start_link(1)
    assert GolServer.state(pid) == 1

    {:ok, pid} = GolServer.start_link(0)
    assert GolServer.state(pid) == 0
  end

  describe "calculate" do
    test "3 x 3" do
      {:ok, pid} = GolServer.start_link(0)

      a = {{1, 0, 0}, {1, 1, 0}, {1, 0, 0}}
      GolServer.calculate(pid, self(), a, 1, 1)

      receive do
        {:ok, ^pid} -> :calculation_done
      end

      assert GolServer.state(pid) == 1
    end

    test "2 x 2" do
      {:ok, pid} = GolServer.start_link(0)

      a = {{1, 0}, {1, 0}}
      GolServer.calculate(pid, self(), a, 1, 1)

      receive do
         {:ok, ^pid} -> :calculation_done
       end

      assert GolServer.state(pid) == 0
    end
  end
end
