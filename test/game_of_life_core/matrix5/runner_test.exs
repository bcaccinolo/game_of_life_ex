defmodule GameOfLifeCore.Matrix5.RunnerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Matrix5.{Runner, StateBuilder, StateAgent}

  test "one_generation performance" do
    config = Application.get_env(:phx_game_of_life, PhxGameOfLifeWeb.RoomChannel, [])
    lines = cols = config[:runner_test_dimension]

    StateBuilder.random_state(lines, cols)
    |> StateBuilder.build_state()
    |> StateAgent.start_link()

    bundle = fn ->
      Runner.one_generation()
    end

    {ms, _} = :timer.tc(bundle)

    IO.puts("Matrix5 #{ms / 1_000_000} sec")
  end
end
