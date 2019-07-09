defmodule PhxGameOfLifeWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    IO.puts("join ok")
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    loop(socket, 0)
    {:noreply, socket}
  end

  def loop(socket, i \\ 5)
  def loop(socket, 0) do
    push(socket, "new_msg", %{body: "bravo!!!"})
    Process.sleep(250)
    loop(socket, 1)
  end
  def loop(socket, 1) do
    push(socket, "new_msg", %{body: "coucou"})
    Process.sleep(250)
    loop(socket, 2)
  end
  def loop(socket, 2) do
    push(socket, "new_msg", %{body: "couco"})
    Process.sleep(250)
    loop(socket, 3)
  end
  def loop(socket, 3) do
    push(socket, "new_msg", %{body: "couc"})
    Process.sleep(250)
    loop(socket, 4)
  end
  def loop(socket, 4) do
    push(socket, "new_msg", %{body: "cou"})
    Process.sleep(250)
    loop(socket, 5)
  end
  def loop(socket, 5) do
    push(socket, "new_msg", %{body: "c"})
    Process.sleep(250)
    loop(socket, 0)
  end



end
