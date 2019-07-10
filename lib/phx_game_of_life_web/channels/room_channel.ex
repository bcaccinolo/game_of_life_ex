defmodule PhxGameOfLifeWeb.RoomChannel do
  use Phoenix.Channel

  # handles the special `"lobby"` subtopic
  def join("room:" <> room, _payload, socket) do
    IO.puts("Connection to lobby done")
    IO.puts(room)
    {:ok, socket}
  end

end
