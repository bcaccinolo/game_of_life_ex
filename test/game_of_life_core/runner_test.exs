defmodule RunnerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.{ Runner, StateBuilder, StateAgent }

  test "one_generation" do
    cell_values = [1, 0, 0, 1, 1, 0, 1, 0, 0]
    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    Runner.one_generation()
    # I create a cell state
    # I iterate
    # I compare
  end
end
