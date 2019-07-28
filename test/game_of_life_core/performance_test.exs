defmodule PerformanceTest do
  use ExUnit.Case

  alias GameOfLifeCore.Runner

  test "performance" do
    bundle = fn ->
      Runner.build_random_board(100, 100)
      IO.puts("Board generated")
      Runner.one_generation()
      IO.puts("New generation calculated")
      Runner.string_state()
      IO.puts("String state generated")
   end

    {ms, _result} = :timer.tc(bundle, [])
    IO.puts("⏰ #{ms / 1_000_000} sec")
  end
end
