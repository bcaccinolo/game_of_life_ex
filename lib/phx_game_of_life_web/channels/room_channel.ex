defmodule PhxGameOfLifeWeb.RoomChannel do
  use Phoenix.Channel

  # handles the special `"lobby"` subtopic
  def join("room:" <> room, _payload, socket) do
    IO.puts("Connection to lobby done")
    IO.puts(room)

    GameOfLifeCore.StateBuilder.random_state(100, 100)
    |> GameOfLifeCore.StateBuilder.build_state()
    |> GameOfLifeCore.StateAgent.start_link()

    {:ok, socket}
  end

  # client asks for their current rank, push sent directly as a new event.
  def handle_in("new_msg", _payload, socket) do
    IO.puts("New message from client")

    board = GameOfLifeCore.StateAgent.state()
    line_count = board |> Tuple.to_list() |> length
    col_count = board |> elem(0) |> Tuple.to_list() |> length

    loop(line_count, col_count, socket)

    {:noreply, socket}
  end

  def loop(line_count, col_count, socket, generation \\ 0) do
    GameOfLifeCore.StateAgent.cell_and_env_list(line_count - 1, col_count - 1)
    |> Enum.map(fn {env, pid} ->
      Task.async(fn -> GameOfLifeCore.GolServer.calculate(pid, env) end)
    end)
    |> Enum.map(fn task -> Task.await(task) end)

    push(socket, "new_msg", %{body: GameOfLifeCore.StateAgent.disp()})

    Process.sleep(100)
    loop(line_count, col_count, socket, generation + 1)
  end
end
