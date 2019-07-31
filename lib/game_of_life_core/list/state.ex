defmodule GameOfLifeCore.List.State do
  @doc """
  Returns the element present at the given coordinates.
  Coordinates are passed cause we manipulate the list as a 2 dimensions matrix.
  If coordinates are out of scope, `:out_of_boundaries` is returned.
  """
  def get(_state, _line, _col, 0, _y), do: :out_of_boundaries
  def get(_state, _line, _col, _x, 0), do: :out_of_boundaries
  def get(state, line, col, x, y), do: Enum.at(state, position(line, col, x, y))

  @doc """
  Returns the index of the value in the list.

  If the coordinates are out of boundaries, 0 is returned.
  """
  def position(_line, _col, x, _y) when x < 1, do: -1
  def position(line, _col, x, _y) when x > line, do: -1
  def position(_line, _col, _x, y) when y < 1, do: -1
  def position(_line, col, _x, y) when y > col, do: -1
  def position(_line, col, x, y), do: col * (x - 1) + y - 1

  @doc """
  From an index of the list, returns the corresponding coordinates of the 2 dimensions matrix.
  """
  def coordinates(index, _line, col) do
    {Kernel.div(index, col) + 1, Kernel.rem(index, col) + 1}
  end
end
