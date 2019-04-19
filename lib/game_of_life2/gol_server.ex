defmodule GameOfLife2.GolServer do
  @moduledoc """
  The server calculating the state of life for a given cell.
  """

  use GenServer

  def start_link(cell_state) do
    GenServer.start_link(__MODULE__, cell_state)
  end

  # Client
  def state(pid) do
    GenServer.call(pid, :state)
  end

  def update(pid, state) do
    GenServer.cast(pid, {:update, state})
  end

  @doc """
  Do the game of life calculation for the cell and it stores the result in the state.
  """
  def calculate(pid, environment, x \\ 1, y \\ 1) do
    GenServer.call(pid, {:calculate, environment, x, y})
  end

  # Server
  def init(state) do
    {:ok, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:calculate, environment, x, y}, _from, _state) do
    result = GameOfLife2.Gol.live_or_let_die(environment, x, y)
    {:reply, result, result}
  end

  def handle_cast({:update, new_state}, _state) do
    {:noreply, new_state}
  end

end
