defmodule GameOfLifeCore.State do
  # Callback invoked by `use`.
  #
  # For now it returns a quoted expression that
  # imports the module itself into the user code.
  @doc false
  defmacro __using__(_opts) do
    quote do
      import GameOfLifeCore.State
    end
  end

  @doc """
  Returns the element present at the given coordinates.
  It manipulates the list as a 2 dimensions matrix.
  """
  def get(state, line, col, x, y) do
    Enum.at(state, position(line, col, x, y))
  end

  @doc """
  Returns the index of the value in the list.
  """
  def position(_line, _col, x, _y) when x < 1, do: :out_of_boundaries
  def position(line, _col, x, _y) when x > line, do: :out_of_boundaries
  def position(_line, _col, _x, y) when y < 1, do: :out_of_boundaries
  def position(_line, col, _x, y) when y > col, do: :out_of_boundaries
  def position(_line, col, x, y), do: col * (x - 1) + y - 1
end
