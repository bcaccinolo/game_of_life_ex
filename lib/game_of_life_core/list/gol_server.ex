defmodule GameOfLifeCore.List.GolServer do
  @moduledoc """
  The server calculating the state of life for a given cell.
  """

  use GenServer

  alias GameOfLifeCore.List.Gol

  def start_link(cell_state) do
    GenServer.start_link(__MODULE__, cell_state)
  end

  # Client
  def state(:out_of_boundaries), do: 0
  def state(nil), do: 0
  def state(pid), do: GenServer.call(pid, :state)

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
    result = Gol.live_or_let_die(environment)
    {:reply, result, result}
  end

end
