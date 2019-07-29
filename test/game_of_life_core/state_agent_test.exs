defmodule StateAgentTest do
  use ExUnit.Case
  alias GameOfLifeCore.{GolServer, State, StateAgent, StateBuilder}
  require IEx

  test "environment_and_cell" do
    {[1, 0, 0, 1, 1, 0, 1, 0, 0] |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    {state, line, col} = StateAgent.state_and_dimensions()

    {res, pid} = StateAgent.environment_and_cell(state, line, col, 0)
    assert res == [0, 0, 0, 0, 1, 0, 0, 1, 1]
    assert is_pid(pid)

    {res, _pid} = StateAgent.environment_and_cell(state, line, col, 2)
    assert res == [0, 0, 0, 0, 0, 0, 1, 0, 0]

    {res, _pid} = StateAgent.environment_and_cell(state, line, col, 5)
    assert res == [0, 0, 0, 1, 0, 0, 0, 0, 0]
  end

  test "environment" do
    {[1, 0, 0, 1, 1, 0, 1, 0, 0] |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    {state, line, col} = StateAgent.state_and_dimensions()

    env = StateAgent.environment(state, line, col, 0)
    assert env == [0, 0, 0, 0, 1, 0, 0, 1, 1]

    env = StateAgent.environment(state, line, col, 2)
    assert env == [0, 0, 0, 0, 0, 0, 1, 0, 0]

    env = StateAgent.environment(state, line, col, 1)
    assert env == [0, 0, 0, 1, 0, 0, 1, 1, 0]

    # angle bas gauche
    env = StateAgent.environment(state, line, col, 6)
    assert env == [0, 1, 1, 0, 1, 0, 0, 0, 0]

    # angle bas droit
    env = StateAgent.environment(state, line, col, 8)
    assert env == [1, 0, 0, 0, 0, 0, 0, 0, 0]

    # bas bordure
    env = StateAgent.environment(state, line, col, 7)
    assert env == [1, 1, 0, 1, 0, 0, 0, 0, 0]

    # côté gauche
    env = StateAgent.environment(state, line, col, 3)
    assert env == [0, 1, 0, 0, 1, 1, 0, 1, 0]

    # coté droit
    env = StateAgent.environment(state, line, col, 5)
    assert env == [0, 0, 0, 1, 0, 0, 0, 0, 0]

    # dans le milieu
    env = StateAgent.environment(state, line, col, 4)
    assert env == [1, 0, 0, 1, 1, 0, 1, 0, 0]
  end

  test "update_cell" do
      {[1, 0, 0, 1, 1, 0, 1, 0, 0] |> StateBuilder.build_genserver_state(), 3, 3}
      |> StateAgent.start_link()

    # coordinates are out of scope
    {status} = StateAgent.update_cell(0, 1, 1)
    assert status == :error

    # coordinates are in the scope
    {status} = StateAgent.update_cell(2, 2, 42)
    assert status == :ok

    # validate the value has been saved
    {state, line, col} = StateAgent.state_and_dimensions()

    cell = State.get(state, line, col, 2, 2) |> GolServer.state()
    assert cell == 42
  end

  test "state_values" do
    cell_values = [1, 0, 0, 1, 1, 0, 1, 0, 0]
    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    assert StateAgent.state_values == cell_values
  end

  test "to_s" do
    cell_values = [1, 0, 0, 1, 1, 0, 1, 0, 0]
    {cell_values |> StateBuilder.build_genserver_state(), 3, 3}
    |> StateAgent.start_link()

    assert StateAgent.to_s == "100\n110\n100\n"
  end

end
