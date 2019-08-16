defmodule GameOfLifeCore.Matrix3.StateAgentTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Matrix3.{StateAgent, StateBuilder}

  test "state_values" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 6]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board = StateAgent.state
    res = StateAgent.state_values(board)

    expected_tuple = {{1, 0, 0, 1},
                      {1, 1, 0, 1},
                      {1, 0, 0, 6}}

    assert res == expected_tuple
  end

  test "extract" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 6]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board = StateAgent.state() |> StateAgent.state_values()
    assert StateAgent.extract(board, 3, 4, 0, 3) == 1
    assert StateAgent.extract(board, 3, 4, 2, 3) == 6
  end

  test "cell_and_environment" do
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board_values = StateAgent.state() |> StateAgent.state_values()
    line_count = board_values |> Tuple.to_list() |> length
    col_count = board_values |> elem(0) |> Tuple.to_list() |> length

    res = StateAgent.cell_and_environment(board_values, line_count, col_count, 0, 1)
    assert res == {{0, 0, 0},
                   {1, 0, 0},
                   {1, 1, 0}}

    res = StateAgent.cell_and_environment(board_values, line_count, col_count, 1, 1)
    assert res == {{1, 0, 0},
                   {1, 1, 0},
                   {1, 0, 0}}

    res = StateAgent.cell_and_environment(board_values, line_count, col_count, 2, 1)
    assert res == {{1, 1, 0},
                   {1, 0, 0},
                   {0, 0, 0}}

    res = StateAgent.cell_and_environment(board_values, line_count, col_count, 2, 2)
    assert res == {{1, 0, 0},
                   {0, 0, 0},
                   {0, 0, 0}}
  end

  test "cell_and_environment 2" do
    [[0, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board_values = StateAgent.state() |> StateAgent.state_values()
    line_count = board_values |> Tuple.to_list() |> length
    col_count = board_values |> elem(0) |> Tuple.to_list() |> length

    res = StateAgent.cell_and_environment(board_values, line_count, col_count, 0, 0)
    assert res == {{0, 0, 0},
                   {0, 0, 0},
                   {0, 1, 1}}
  end

  test "cell_and_environment 3" do
    [[1, 0, 0, 1, 1],
     [1, 1, 0, 1, 1],
     [1, 0, 0, 1, 6]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board_values = StateAgent.state() |> StateAgent.state_values()
    line_count = board_values |> Tuple.to_list() |> length
    col_count = board_values |> elem(0) |> Tuple.to_list() |> length

    res = StateAgent.cell_and_environment(board_values, line_count, col_count, 2, 3)
    assert res == {{0, 1, 1},
                   {0, 1, 6},
                   {0, 0, 0}}
  end

  test "build_line" do
    [[1, 0, 0],
    [1, 1, 0],
    [1, 0, 0]]
   |> StateBuilder.build_state
   |> StateAgent.start_link

   state = StateAgent.state
   state_line = elem(state, 1)
   res = StateAgent.build_line(state_line, 3)
   assert res == "110"
  end

end
