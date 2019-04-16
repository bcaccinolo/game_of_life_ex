defmodule ApplicationTest do
  use ExUnit.Case
  doctest GameOfLife2

  test "launch" do
   IO.puts("ici")
   GameOfLife2.Application.launch()
  end

end
