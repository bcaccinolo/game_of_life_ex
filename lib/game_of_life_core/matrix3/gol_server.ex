defmodule GameOfLifeCore.Matrix3.GolServer do
  @moduledoc """
  The server calculating the state of life for a given cell.
  """

  alias GameOfLifeCore.Matrix.Gol

  use GenServer

  def start_link(cell_state) do
    GenServer.start_link(__MODULE__, cell_state)
  end

  # Client
  def state(pid) do
    GenServer.call(pid, :state)
  end

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

  def handle_call({:calculate, environment, line, col}, _from, _state) do
    result = Gol.live_or_let_die(environment, line, col)
    {:reply, result, result}
  end

  def handle_cast({:calculate, environment, line, col}, _state) do
    result = Gol.live_or_let_die(environment, line, col)
    {:noreply, result}
  end

end
