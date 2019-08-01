defmodule GameOfLifeCore.List.RunnerTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.List.{ Runner, StateBuilder, StateAgent }

  test "one_generation: 3 cells in line rotates the line" do
    cell_values = [0, 1, 0,
                   0, 1, 0,
                   0, 1, 0]

    expected    = [0, 0, 0,
                   1, 1, 1,
                   0, 0, 0]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end

  test "one_generation: 1 lonely cell" do
    cell_values = [0, 0, 0,
                   0, 1, 0,
                   0, 0, 0]

    expected    = [0, 0, 0,
                   0, 0, 0,
                   0, 0, 0]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end


  test "one_generation: 2 cells together" do
    cell_values = [0, 1, 0,
                   0, 1, 0,
                   0, 0, 0]

    expected    = [0, 0, 0,
                   0, 0, 0,
                   0, 0, 0]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end

  test "one_generation: 3 cells together" do
    cell_values = [0, 1, 0,
                   0, 1, 1,
                   0, 0, 0]

    expected    = [0, 1, 1,
                   0, 1, 1,
                   0, 0, 0]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end

  test "one_generation: 4 cells in square" do
    cell_values = [0, 1, 1,
                   0, 1, 1,
                   0, 0, 0]

    expected    = [0, 1, 1,
                   0, 1, 1,
                   0, 0, 0]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end

  test "one_generation: 4 cells" do
    cell_values = [0, 1, 1,
                   0, 1, 0,
                   0, 1, 0]

    expected    = [0, 1, 1,
                   1, 1, 0,
                   0, 0, 0]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end

  test "one_generation: 4 cells v2" do
    cell_values = [0, 1, 0,
                   0, 1, 1,
                   0, 1, 0]

    expected    = [0, 1, 1,
                   1, 1, 1,
                   0, 1, 1]

    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    state = StateAgent.state()

    Runner.one_generation()

    assert StateAgent.state_values(state) == expected
  end

end
