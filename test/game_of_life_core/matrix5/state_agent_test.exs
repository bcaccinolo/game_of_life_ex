defmodule GameOfLifeCore.Matrix5.StateAgentTest do
  use ExUnit.Case
  doctest GameOfLifeCore

  alias GameOfLifeCore.Matrix5.{StateAgent, StateBuilder}

  test "extract" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 6]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board = StateAgent.state
    assert StateAgent.extract(board, 3, 4, 0, 3) == 1
    assert StateAgent.extract(board, 3, 4, 2, 3) == 6
  end

  test "cell_and_environment" do
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board = StateAgent.state()

    {res, _pid} = StateAgent.cell_and_environment(board, 0, 1)
    assert res == {{0, 0, 0},
                   {1, 0, 0},
                   {1, 1, 0}}

    {res, _pid} = StateAgent.cell_and_environment(board, 1, 1)
    assert res == {{1, 0, 0},
                   {1, 1, 0},
                   {1, 0, 0}}

    {res, _pid} = StateAgent.cell_and_environment(board, 2, 1)
    assert res == {{1, 1, 0},
                   {1, 0, 0},
                   {0, 0, 0}}

    {res, _pid} = StateAgent.cell_and_environment(board, 2, 2)
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

    board = StateAgent.state()

    {res, _pid} = StateAgent.cell_and_environment(board, 0, 0)
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

    board = StateAgent.state()

    {res, _pid} = StateAgent.cell_and_environment(board, 2, 3)
    assert res == {{0, 1, 1},
                   {0, 1, 6},
                   {0, 0, 0}}
  end

  test "cell_and_env_line_list" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 1]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board = StateAgent.state()
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    res = StateAgent.cell_and_env_line_list(board, line_count - 1, col_count - 1)
    assert length(res) == 4
  end

  test "cell_and_env_list" do
    [[1, 0, 0, 1],
     [1, 1, 0, 1],
     [1, 0, 0, 1]]
    |> StateBuilder.build_state
    |> StateAgent.start_link

    board = StateAgent.state()
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    res = StateAgent.cell_and_env_list(board, line_count - 1, col_count - 1)
    assert length(res) == 12
  end

  test "build_line" do
    [[1, 0, 0],
    [1, 1, 0],
    [1, 0, 0]]
   |> StateBuilder.build_state
   |> StateAgent.start_link

   state = StateAgent.state()
   state_line = elem(state, 1)
   res = StateAgent.build_line(state_line, 3)
   assert res == "110"
  end

end
