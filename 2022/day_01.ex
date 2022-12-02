defmodule Day01 do
  def part_1(input) do
    input
    |> format
    |> Enum.max
  end

  def part_2(input) do
    input
    |> format
    |> Enum.sort
    |> Enum.take(-3)
    |> Enum.sum
  end

  defp format(input) do
    input
    |> String.split("\n")
    |> Enum.reduce([], &reduce_fn(&1, &2))
  end

  defp reduce_fn(x, []), do: [String.to_integer(x)]
  defp reduce_fn("", acc), do: [0 | acc]
  defp reduce_fn(x, acc) do
    [head | tail] = acc
    [head + String.to_integer(x) | tail]
  end
end

ExUnit.start()
defmodule Day01Part1Test do
  use ExUnit.Case

  setup_all do
    {:ok, test_data} = File.read("day_01_part_01_test.txt")
    {:ok, real_data} = File.read("day_01_part_01.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = Day01.part_1(context[:test_data])
      IO.puts("1/ test input: #{test_result}")
      assert test_result == 24_000
    end

    test "real data", context do
      real_result = Day01.part_1(context[:real_data])
      IO.puts("1/ real input: #{real_result}")
      assert real_result
    end
  end

  describe "part 2" do
    test "test data", context do
      test_result = Day01.part_2(context[:test_data])
      IO.puts("2/ test input: #{test_result}")
      assert test_result == 45_000
    end

    test "real data", context do
      real_result = Day01.part_2(context[:real_data])
      IO.puts("2/ real input: #{real_result}")
      assert real_result
    end
  end
end
