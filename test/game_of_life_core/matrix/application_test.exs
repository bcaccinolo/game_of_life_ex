defmodule ApplicationTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Application

  test "one_generation performance" do

    lines = 100
    cols = 100

    GameOfLifeCore.StateBuilder.random_state(lines, cols)
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    bundle = fn ->
      Application.one_generation(lines, cols)
    end

    {ms, _} = :timer.tc(bundle)

    IO.puts("Deactivated #{ms / 1_000_000} sec")
  end

end
