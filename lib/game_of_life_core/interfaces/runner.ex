defmodule Interfaces.Runner do
  @moduledoc """
  Public interface of Game of Life Core
  """

  @callback build_random_board(integer, integer) :: {:ok}

  @callback one_generation() :: String.t
end
