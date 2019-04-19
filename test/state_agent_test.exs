defmodule StateAgentTest do
  use ExUnit.Case
  doctest GameOfLife2

  require IEx


  test "extract" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 6]]
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    board = GameOfLife2.StateAgent.state
    assert GameOfLife2.StateAgent.extact(board, 3, 4, 0, 3) == 1
    assert GameOfLife2.StateAgent.extact(board, 3, 4, 2, 3) == 6
  end

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

  test "cell_and_environment 2" do
    [[0, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    {res, _pid} = GameOfLife2.StateAgent.cell_and_environment(0, 0)
    assert res == {{0, 0, 0},
                   {0, 0, 0},
                   {0, 1, 1}}
  end

  test "cell_and_environment 3" do
    [[1, 0, 0, 1, 1],
     [1, 1, 0, 1, 1],
     [1, 0, 0, 1, 6]]
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    {res, _pid} = GameOfLife2.StateAgent.cell_and_environment(2, 3)
    assert res == {{0, 1, 1},
                   {0, 1, 6},
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

  test "disp" do
    [[1, 0, 0],
    [1, 1, 0],
    [1, 0, 0]]
   |> GameOfLife2.StateBuilder.build_state
   |> GameOfLife2.StateAgent.start_link

   GameOfLife2.StateAgent.disp
  end

end
