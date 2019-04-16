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
    # create the board
    [[1, 0, 0],
     [1, 1, 0],
     [1, 0, 0]]
    |> GameOfLife2.StateBuilder.build_state
    |> GameOfLife2.StateAgent.start_link

  end

end
