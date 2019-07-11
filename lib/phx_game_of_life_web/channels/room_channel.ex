defmodule PhxGameOfLifeWeb.RoomChannel do
  use Phoenix.Channel

  # handles the special `"lobby"` subtopic
  def join("room:" <> room, _payload, socket) do
    IO.puts("Connection to lobby done")

    GameOfLifeCore.Runner.build_board(100, 100)

    {:ok, socket}
  end

  # client asks for their current rank, push sent directly as a new event.
  def handle_in("new_msg", _payload, socket) do
    IO.puts("New message from client")

    # push(socket, "new_msg", %{body: "coucoc le monde"})
    # broadcast_from(socket, "new_msg", %{body: "coucoc le monde"})
    # broadcast(socket, "new_msg", %{body: "coucoc le monde"})

    GameOfLifeCore.Runner.disp()


    {:noreply, socket}
  end

end
