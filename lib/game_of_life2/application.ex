defmodule GameOfLife2.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: GameOfLife2.Worker.start_link(arg)
      # {GameOfLife2.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GameOfLife2.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def launch() do
    GameOfLife2.StateBuilder.random_state(35, 130)
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    board = GameOfLife2.StateAgent.state
    line_count = board |> Tuple.to_list |> length
    col_count = board |> elem(0) |> Tuple.to_list |> length

    ExNcurses.initscr()
    ExNcurses.curs_set(0) # no cursor

    loop(line_count, col_count)
  end

  def loop(line_count, col_count) do

    for line <- 0..(line_count - 1), col <- 0..(col_count - 1) do
      {env, pid} = GameOfLife2.StateAgent.cell_and_environment(line, col)
      GameOfLife2.GolServer.calculate(pid, env)
    end

    GameOfLife2.StateAgent.disp
    Process.sleep(200)
    loop(line_count, col_count)
  end

end
