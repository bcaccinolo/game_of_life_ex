defmodule GameOfLife2.Runner do

  def launch() do

    # init NCurses
    ExNcurses.initscr()
    # lines = ExNcurses.lines
    # cols = ExNcurses.cols
    lines = 100
    cols = 100
    ExNcurses.curs_set(0) # no cursor

    GameOfLife2.StateBuilder.random_state(lines - 1, cols - 1)
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    board = GameOfLife2.StateAgent.state
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    loop(line_count, col_count)
  end

  def loop(line_count, col_count, generation \\ 0) do
    one_generation(line_count, col_count)

    GameOfLife2.StateAgent.disp
    # Process.sleep(10)
    loop(line_count, col_count, generation + 1)
  end

  @doc """
  Do the calculation for one cell iteration.
  No display is done
  """
  def one_generation(line_count, col_count) do
    GameOfLife2.StateAgent.cell_and_env_list(line_count - 1, col_count - 1)
    |> Enum.map(fn({env, pid}) -> Task.async(fn() -> GameOfLife2.GolServer.calculate(pid, env) end) end)
    |> Enum.map(fn(task) -> Task.await(task) end)
  end

  def to_s
  end

end
