defmodule PhxGameOfLifeWeb.RoomChannel do
  use Phoenix.Channel

  # handles the special `"lobby"` subtopic
  def join("room:" <> _room, _payload, socket) do
    # IO.puts("Connection to lobby done")

    # GameOfLifeCore.Runner.build_random_board(50, 50)
    GameOfLifeCore.Runner.build_random_board(100, 100)

    {:ok, socket}
  end

  # client asks for their current rank, push sent directly as a new event.
  def handle_in("one_step", _payload, socket) do
    IO.puts("New step requested from client")

    # push(socket, "new_msg", %{body: "coucoc le monde"})
    # broadcast_from(socket, "new_msg", %{body: "coucoc le monde"})
    # broadcast(socket, "new_msg", %{body: "coucoc le monde"})

    GameOfLifeCore.Runner.one_generation()
    IO.puts("New step calculated")
    state = GameOfLifeCore.Runner.string_state()
    IO.puts("State converted to string")
    push(socket, "one_step", %{body: state})

    {:noreply, socket}
  end

end
