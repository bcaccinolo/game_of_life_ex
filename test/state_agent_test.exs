defmodule StateAgentTest do
  use ExUnit.Case
  doctest GameOfLife2

  require IEx

  test "cell_and_environment" do
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    {res, _pid} = GameOfLife2.StateAgent.cell_and_environment(0, 1)
    assert res == {{0, 0, 0},
                   {1, 0, 0},
                   {1, 1, 0}}

    {res, _pid} = GameOfLife2.StateAgent.cell_and_environment(1, 1)
    assert res == {{1, 0, 0},
                   {1, 1, 0},
                   {1, 0, 0}}

    {res, _pid} = GameOfLife2.StateAgent.cell_and_environment(2, 1)
    assert res == {{1, 1, 0},
                   {1, 0, 0},
                   {0, 0, 0}}
  end

  test "update_cell" do
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    GameOfLife2.StateAgent.update_cell(0, 1, 1)

    {res, _pid} = GameOfLife2.StateAgent.cell_and_environment(1, 1)
    assert res == {{1, 1, 0},
                   {1, 1, 0},
                   {1, 0, 0}}
  end

end
