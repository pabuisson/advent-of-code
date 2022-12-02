defmodule Day02 do
  def part_1(input) do
    input
    |> format
    |> Enum.map(fn([_, ours] = couple) -> score(ours) + score(couple) end)
    |> Enum.sum
  end

  def part_2(input) do
    input
    |> format
    |> Enum.map(fn([theirs, expected_output]) -> [theirs, our_move(expected_output, theirs)] end)
    |> Enum.map(fn([_, ours] = couple) -> score(ours) + score(couple) end)
    |> Enum.sum
  end

  defp format(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " "))
  end

  defp score([_, _] = couple) do
    equal = [["A", "X"], ["B", "Y"], ["C", "Z"]]
    lost = [["A", "Z"], ["B", "X"], ["C", "Y"]]

    cond do
      couple in equal -> 3
      couple in lost -> 0
      true -> 6
    end
  end

  defp score(our_move), do: %{"X" => 1, "Y" => 2, "Z" => 3}[our_move]

  # Lose
  defp our_move("X", their_move), do: %{"A" => "Z", "B" => "X", "C" => "Y"}[their_move]
  # Draw
  defp our_move("Y", their_move), do: %{"A" => "X", "B" => "Y", "C" => "Z"}[their_move]
  # Win
  defp our_move("Z", their_move), do: %{"A" => "Y", "B" => "Z", "C" => "X"}[their_move]
end


ExUnit.start(exclude: [:skip])
defmodule Day02Part1Test do
  use ExUnit.Case

  setup_all do
    {:ok, test_data} = File.read("day_02_part_01_test.txt")
    {:ok, real_data} = File.read("day_02_part_01.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = Day02.part_1(context[:test_data])
      IO.puts("1/ test input: #{test_result}")
      assert test_result == 15
    end

    test "real data", context do
      real_result = Day02.part_1(context[:real_data])
      IO.puts("1/ real input: #{real_result}")
      assert real_result
    end
  end

  describe "part 2" do
    test "test data", context do
      test_result = Day02.part_2(context[:test_data])
      IO.puts("2/ test input: #{test_result}")
      assert test_result == 12
    end

    test "real data", context do
      real_result = Day02.part_2(context[:real_data])
      IO.puts("2/ real input: #{real_result}")
      assert real_result
    end
  end
end
