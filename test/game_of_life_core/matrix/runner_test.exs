defmodule GameOfLifeCore.Matrix.RunnerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Matrix.{Runner, StateBuilder, StateAgent}

  test "one_generation performance" do

    lines = 100
    cols = 100

    StateBuilder.random_state(lines, cols)
    |> StateBuilder.build_state
    |> StateAgent.start_link

    bundle = fn ->
      Runner.one_generation
    end

    {ms, _} = :timer.tc(bundle)

    IO.puts("Matrix #{ms / 1_000_000} sec")
  end

end
