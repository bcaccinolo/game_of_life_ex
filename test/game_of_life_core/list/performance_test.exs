defmodule GameOfLifeCore.List.PerformanceTest do
  use ExUnit.Case

  # alias GameOfLifeCore.List.Runner

  # test "performance" do
  #   bundle = fn ->
  #     Runner.build_random_board(100, 100)
  #     IO.puts("Board generated")

  #     Runner.one_generation()
  #     IO.puts("New generation calculated")
  #  end

  #   {ms, _result} = :timer.tc(bundle, [])
  #   IO.puts("⏰ #{ms / 1_000_000} sec")
  # end


  # test "tuple / list itration speed" do
  #   bundle_list = fn ->
  #     (1..1_000_000)
  #     |> Enum.each(fn _ ->
  #       list = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
  #       Enum.each(list, fn (e) -> e + 1 end)
  #     end)
  #   end

  #   bundle_tuple = fn ->
  #     (1..1_000_000)
  #     |> Enum.each(fn _ ->
  #       tuple = {1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0}
  #       size = tuple_size(tuple) - 1
  #       (1..size)
  #       |> Enum.each(fn (index) -> elem(tuple, index) + 1 end)
  #     end)
  #   end

  #   {ms1, _result} = :timer.tc(bundle_list, [])
  #   {ms2, _result} = :timer.tc(bundle_tuple, [])

  #   IO.puts("⏰ List : #{ms1 / 1_000_000} sec")
  #   IO.puts("⏰ Tuple #{ms2 / 1_000_000} sec")
  # end

end
