defmodule Day03 do
  def part_1(input) do
    input
    |> format
    |> Enum.map(&String.split_at(&1, div(String.length(&1), 2)))
    |> Enum.map(fn({left, right}) -> {String.codepoints(left), String.codepoints(right)} end)
    |> Enum.map(&common_char(&1))
    |> Enum.map(&priority(&1))
    |> Enum.sum
  end

  def part_2(input) do
    input
    |> format
    |> Enum.map(&String.codepoints(&1))
    |> Enum.chunk_every(3)
    |> Enum.flat_map(&common_char(&1))
    |> Enum.map(&priority(&1))
    |> Enum.sum
  end

  defp format(input) do
    input |> String.split("\n", trim: true)
  end

  # a-z: 1-26
  # A-Z: 27-52
  # iex(3)> "a" |> String.to_charlist |> hd : 97
  # iex(4)> "A" |> String.to_charlist |> hd : 65
  defp priority(c) do
    delta =
      cond do
        String.match?(c, ~r/[a-z]/) -> 96
        String.match?(c, ~r/[A-Z]/) -> 38
      end

    c
    |> String.to_charlist
    |> hd
    |> Kernel.-(delta)
  end

  defp common_char({ left_chars, right_chars }) do
    left_chars
    |> Enum.find(fn(c) -> c in right_chars end)
  end

  defp common_char([first, second, third]) do
    first
    |> Enum.filter(fn(c) -> c in second end)
    |> Enum.filter(fn(c) -> c in third end)
    |> Enum.uniq
  end
end


ExUnit.start(exclude: [:skip])
defmodule Day03Test do
  use ExUnit.Case

  setup_all do
    {:ok, test_data} = File.read("day_03_part_01_test.txt")
    {:ok, real_data} = File.read("day_03_part_01.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = Day03.part_1(context[:test_data])
      IO.puts("1/ test input: #{test_result}")
      assert test_result == 157
    end

    test "real data", context do
      real_result = Day03.part_1(context[:real_data])
      IO.puts("1/ real input: #{real_result}")
      assert real_result
    end
  end

  describe "part 2" do
    test "test data", context do
      test_result = Day03.part_2(context[:test_data])
      IO.puts("2/ test input: #{test_result}")
      assert test_result == 70
    end

    test "real data", context do
      real_result = Day03.part_2(context[:real_data])
      IO.puts("2/ real input: #{real_result}")
      assert real_result
    end
  end
end
