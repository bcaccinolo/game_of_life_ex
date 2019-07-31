defmodule GameOfLifeCore.Runner do

  def launch() do

    # init NCurses
    ExNcurses.initscr()
    # lines = ExNcurses.lines
    # cols = ExNcurses.cols
    lines = 100
    cols = 100
    ExNcurses.curs_set(0) # no cursor

    GameOfLifeCore.StateBuilder.random_state(lines - 1, cols - 1)
    |> GameOfLifeCore.StateBuilder.build_state
    |> GameOfLifeCore.StateAgent.start_link

    board = GameOfLifeCore.StateAgent.state
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    loop(line_count, col_count)
  end

  def loop(line_count, col_count, generation \\ 0) do
    one_generation(line_count, col_count)

    GameOfLifeCore.StateAgent.disp
    # Process.sleep(10)
    loop(line_count, col_count, generation + 1)
  end

  @doc """
  Do the calculation for one cell iteration.
  No display is done
  """
  def one_generation(line_count, col_count) do
    GameOfLifeCore.StateAgent.cell_and_env_list(line_count - 1, col_count - 1)
    |> Enum.map(fn({env, pid}) -> Task.async(fn() -> GameOfLifeCore.GolServer.calculate(pid, env) end) end)
    |> Enum.map(fn(task) -> Task.await(task) end)
  end

  def to_s
  end

end
