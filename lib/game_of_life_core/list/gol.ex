defmodule GameOfLifeCore.List.Gol do
  @moduledoc """
  Implementation of the Game Of Life logic
  """

  @doc """
  Do the calcultation

  ## Params
    - environment: the list

  Returns the value of the cell.
  """
  def live_or_let_die(environment) do
    calculate(neighbours(environment), Enum.at(environment, 4))
  end

  @doc """
  Proxy doing the Game of life calculation.
  It's useful to do this to use `guards`.
  """
  def calculate(n, _) when n == 3 , do: 1
  def calculate(n, v) when n == 2 , do: v
  def calculate(n, _) when n > 3  , do: 0
  def calculate(n, _) when n < 2  , do: 0

  @doc """
  Calculate the amount of living cells around the observed point.

  ## Params
    - environment: a tuple of 3 tuples containing the value of the cell and the one around.
    - col, line: the coordinates of the cell to evaluate in regard of its environment.

  Returns the value of the cell.
  """
  def neighbours(environment) do
    sumMatrix(environment) - Enum.at(environment, 4)
  end

  @doc """
  Sum the content of a Liest

  Returns the sum.
  """
  def sumMatrix(list) do
    Enum.reduce(list, 0, fn (v, acc) -> acc + v end)
  end

end

