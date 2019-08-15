defmodule PhxGameOfLifeWeb.RoomChannel do
  use Phoenix.Channel

  # handles the special `"lobby"` subtopic
  def join("room:" <> _room, _payload, socket) do
    IO.puts("Connection to lobby done")

    config = Application.get_env(:phx_game_of_life, __MODULE__, [])
    gol_runner = config[:adapter]
    # gol_runner.build_random_board(50, 50)
    gol_runner.build_random_board(100, 100)

    {:ok, socket}
  end

  # client asks for their current rank, push sent directly as a new event.
  def handle_in("one_step", _payload, socket) do
    IO.puts("New step requested from client")

    config = Application.get_env(:phx_game_of_life, __MODULE__, [])
    gol_runner = config[:adapter]
    gol_runner.build_random_board(50, 50)

    string_state = gol_runner.one_generation()
    push(socket, "one_step", %{body: string_state})

    IO.puts(string_state)

    {:noreply, socket}
  end

end
