defmodule GameOfLifeCore.GolServer do
  @moduledoc """
  The server calculating the state of life for a given cell.
  """

  use GenServer

  def start_link(cell_state) do
    GenServer.start_link(__MODULE__, cell_state)
  end

  # Client
  def state(:out_of_boundaries), do: 0
  def state(nil), do: 0
  def state(pid), do: GenServer.call(pid, :state)

  def update(:out_of_boundaries, _state), do: {:error}
  def update(pid, state), do: GenServer.cast(pid, {:update, state})

  @doc """
  Do the game of life calculation for the cell and it stores the result in the state.
  """
  def calculate(pid, environment, line \\ 1, col \\ 1) do
    GenServer.call(pid, {:calculate, environment, line, col})
  end

  # Server
  def init(state) do
    {:ok, state}
  end

  def handle_call(:state, _from, state) do
    {:reply, state, state}
  end

  def handle_call({:calculate, environment, _line, _col}, _from, _state) do
    result = GameOfLifeCore.Gol.live_or_let_die(environment)
    {:reply, result, result}
  end

  def handle_cast({:update, new_state}, _state) do
    {:noreply, new_state}
  end

end