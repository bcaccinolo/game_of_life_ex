defmodule StateAgentTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  require IEx


  test "extract" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 6]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    board = GameOfLifeCore.StateAgent.state
    assert GameOfLifeCore.StateAgent.extract(board, 3, 4, 0, 3) == 1
    assert GameOfLifeCore.StateAgent.extract(board, 3, 4, 2, 3) == 6
  end

  test "cell_and_environment" do
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(0, 1)
    assert res == {{0, 0, 0},
                   {1, 0, 0},
                   {1, 1, 0}}

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(1, 1)
    assert res == {{1, 0, 0},
                   {1, 1, 0},
                   {1, 0, 0}}

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(2, 1)
    assert res == {{1, 1, 0},
                   {1, 0, 0},
                   {0, 0, 0}}

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(2, 2)
    assert res == {{1, 0, 0},
                   {0, 0, 0},
                   {0, 0, 0}}
  end

  test "cell_and_environment 2" do
    [[0, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(0, 0)
    assert res == {{0, 0, 0},
                   {0, 0, 0},
                   {0, 1, 1}}
  end

  test "cell_and_environment 3" do
    [[1, 0, 0, 1, 1],
     [1, 1, 0, 1, 1],
     [1, 0, 0, 1, 6]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(2, 3)
    assert res == {{0, 1, 1},
                   {0, 1, 6},
                   {0, 0, 0}}
  end

  test "cell_and_env_line_list" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 1]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    board = GameOfLifeCore.StateAgent.state
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    res = GameOfLifeCore.StateAgent.cell_and_env_line_list(line_count - 1, col_count - 1)
    assert length(res) == 4
  end

  test "cell_and_env_list" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 1]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    board = GameOfLifeCore.StateAgent.state
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    res = GameOfLifeCore.StateAgent.cell_and_env_list(line_count - 1, col_count - 1)
    assert length(res) == 12
  end

  test "update_cell" do
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    GameOfLifeCore.StateAgent.update_cell(0, 1, 1)

    {res, _pid} = GameOfLifeCore.StateAgent.cell_and_environment(1, 1)
    assert res == {{1, 1, 0},
                   {1, 1, 0},
                   {1, 0, 0}}
  end

  test "build_line" do
    [[1, 0, 0],
    [1, 1, 0],
    [1, 0, 0]]
   |> GameOfLifeCore.StateBuilder.build_state
   |> GameOfLifeCore.StateAgent.start_link

   state = GameOfLifeCore.StateAgent.state
   state_line = elem(state, 1)
   res = GameOfLifeCore.StateAgent.build_line(state_line, 3)
   assert res == "++."
  end

end
