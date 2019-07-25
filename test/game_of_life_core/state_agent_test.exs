defmodule StateAgentTest do
  use ExUnit.Case
  use GameOfLifeCore.StateAgent
  require IEx

  test "environment_and_cell" do
    {[1, 0, 0, 1, 1, 0, 1, 0, 0] |> GameOfLifeCore.StateBuilder.build_genserver_state(), 3, 3}
    |> GameOfLifeCore.StateAgent.start_link()

    {res, pid} = GameOfLifeCore.StateAgent.environment_and_cell(1, 1)
    assert res == [0, 0, 0, 0, 1, 0, 0, 1, 1]
    assert is_pid(pid)

    {res, _pid} = GameOfLifeCore.StateAgent.environment_and_cell(2, 2)
    assert res == [1, 0, 0, 1, 1, 0, 1, 0, 0]

    {res, _pid} = GameOfLifeCore.StateAgent.environment_and_cell(2, 3)
    assert res == [0, 0, 0, 1, 0, 0, 0, 0, 0]
  end

  test "update_cell" do
    {[1, 0, 0, 1, 1, 0, 1, 0, 0] |> GameOfLifeCore.StateBuilder.build_genserver_state(), 3, 3}
    |> GameOfLifeCore.StateAgent.start_link()

    # coordinates are out of scope
    {status} = GameOfLifeCore.StateAgent.update_cell(0, 1, 1)
    assert status == :error

    # coordinates are in the scope
    {status} = GameOfLifeCore.StateAgent.update_cell(2, 2, 42)
    assert status == :ok

    # validate the value has been saved
    state = GameOfLifeCore.StateAgent.state()
    {line, col} = GameOfLifeCore.StateAgent.dimensions()
    cell = GameOfLifeCore.State.get(state, line, col, 2, 2) |> GameOfLifeCore.GolServer.state
    assert cell == 42
  end
end
