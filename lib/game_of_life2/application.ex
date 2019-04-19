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
    GameOfLife2.StateBuilder.random_state(10, 20)
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

    board = GameOfLife2.StateAgent.state
    x_len = board |> Tuple.to_list |> length
    y_len = board |> elem(0) |> Tuple.to_list |> length

    # IO.puts("x is #{x_len}")
    # IO.puts("y is #{y_len}")

    ExNcurses.initscr()

    loop(x_len, y_len)
  end

  def loop(x_len, y_len) do

    for x <- 0..(x_len - 1), y <- 0..(y_len - 1) do
      {env, pid} = GameOfLife2.StateAgent.cell_and_environment(x,y)
      GameOfLife2.GolServer.calculate(pid, env)
    end

    GameOfLife2.StateAgent.disp
    Process.sleep(200)
    loop(x_len, y_len)
  end

end
