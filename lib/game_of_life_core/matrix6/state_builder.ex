defmodule GameOfLifeCore.Matrix6.StateBuilder do
  use Agent

  alias GameOfLifeCore.Matrix6.GolServer

  @doc """
  Build the GenServer states from the cell values.
  This state {{1, 0, 1}, will give a list of GenServers.
              {1, 1, 1},
              {1, 0, 1}}
  """
  def build_state(state, result \\ [])

  def build_state([h | t], result) do
    res = List.insert_at(result, length(result), build_state_from_list(h))
    build_state(t, res)
  end

  def build_state([], result), do: List.to_tuple(result)

  @doc """
  Returns a tuple of GenServes pids.
  """
  def build_state_from_list(list, result \\ [])

  def build_state_from_list([h | t], result) do
    {:ok, pid} = build_state_from_value(h)
    res = List.insert_at(result, length(result), pid)
    build_state_from_list(t, res)
  end

  def build_state_from_list([], result), do: List.to_tuple(result)

  @doc """
  Returns a GenServes pid.
  """
  def build_state_from_value(v) do
    GolServer.start_link(v)
  end

  @doc """
  Generate a random state to start the game of life.
  """
  def random_state(line_count, col_count)
  def random_state(0, _col_count), do: []

  def random_state(line_count, col_count),
    do: [random_list(col_count)] ++ random_state(line_count - 1, col_count)

  def random_list(len)
  def random_list(0), do: []
  def random_list(len), do: [:rand.uniform(2) - 1] ++ random_list(len - 1)

  def update_servers_with_neighbors(pid_board) do
    line_count = pid_board |> Tuple.to_list() |> length
    col_count = pid_board |> elem(0) |> Tuple.to_list() |> length

    Enum.map(0..(line_count - 1), fn x ->
      Enum.map(0..(col_count - 1), fn y ->
        {elem(elem(pid_board, x), y), cell_and_environment(pid_board, x, y)}
      end) |> List.to_tuple
    end) |> List.to_tuple
  end

  def cell_and_environment(board, line, col) do
    line_count = board |> Tuple.to_list() |> length
    col_count = board |> elem(0) |> Tuple.to_list() |> length

    [
      extract(board, line_count, col_count, line - 1, col - 1),
      extract(board, line_count, col_count, line - 1, col),
      extract(board, line_count, col_count, line - 1, col + 1),
      extract(board, line_count, col_count, line, col - 1),
      extract(board, line_count, col_count, line, col + 1),
      extract(board, line_count, col_count, line + 1, col - 1),
      extract(board, line_count, col_count, line + 1, col),
      extract(board, line_count, col_count, line + 1, col + 1)
    ]
    |> Enum.filter(fn pid -> pid != 0 end)
  end

  def extract(_board, _line_count, _col_count, line, _col) when line < 0, do: 0
  def extract(_board, _line_count, _col_count, _line, col) when col < 0, do: 0
  def extract(_board, line_count, _col_count, line, _col) when line >= line_count, do: 0
  def extract(_board, _line_count, col_count, _line, col) when col >= col_count, do: 0

  def extract(board, _line_count, _col_count, line, col) do
    elem(elem(board, line), col)
  end
end
