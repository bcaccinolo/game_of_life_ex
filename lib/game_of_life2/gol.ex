defmodule GameOfLife2.Gol do
  @moduledoc """
  Implementation of the Game Of Life logic
  """

  # Callback invoked by `use`.
  #
  # For now it returns a quoted expression that
  # imports the module itself into the user code.
  @doc false
  defmacro __using__(_opts) do
    quote do
      import GameOfLife2.Gol
    end
  end

  @doc """
  Do the calcultation

  ## Params
    - environment: a tuple of 3 tuples containing the value of the cell and the one around.
                 example: {{1, 0, 1},
                           {1, 1, 1},
                           {1, 0, 1}}
                  it can also be :
                 example: {{1, 0},
                           {1, 1},
                           {1, 0}}
                  if the cell is on the border. Or even:
                 example: {{1, 0},
                           {1, 0}}
                  if the cell is in a corner.

    - line & col: the coordinates of the cell to evaluate in regard of its environment.

  Returns the value of the cell.
  """
  def live_or_let_die(environment, line, col) do
    calculate(neighbours(environment, line, col), elem(elem(environment, line), col))
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
  def neighbours(environment, line, col) do
    sumMatrix(environment) - elem(elem(environment, line), col)
  end

  @doc """
  Sum the content of a Matrix made of tuples.

  ## Params
    - matrix: the list to sum.
    - result: the accumulator.

  Returns the sum.
  """
  def sumMatrix(matrix, result \\ 0)
  def sumMatrix({a, b, c}, result) do sumMatrix({b, c}, result + GameOfLife2.Gol.sumList(Tuple.to_list(a))) end
  def sumMatrix({a, b}, result) do sumMatrix({b}, result + GameOfLife2.Gol.sumList(Tuple.to_list(a))) end
  def sumMatrix({a}, result) do result + GameOfLife2.Gol.sumList(Tuple.to_list(a)) end
  def sumMatrix({}, result) do result end

  @doc """
  Sum all the elem of a list.

  ## Params
    - list: the list to sum.
    - result: the accumulator.

  Returns the sum.
  """
  def sumList(list, result \\ 0)
  def sumList([hd | tl], result) do sumList(tl, result + hd) end
  def sumList([], result)        do result end

end

