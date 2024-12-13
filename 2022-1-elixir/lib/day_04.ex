defmodule Day04 do
  def part_1(input) do
    input
    |> format
    |> Enum.count(fn([left, right]) ->
      covers(left, right) || covers(right, left)
    end)
  end

  def part_2(input) do
    input
    |> format
    |> Enum.count(fn([left, right]) ->
      overlaps(left, right)
    end)
  end

  defp format(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn([first, second]) ->
      [
        first
        |> String.split("-")
        |> Enum.map(&String.to_integer(&1)),
        second
        |> String.split("-")
        |> Enum.map(&String.to_integer(&1))
      ]
    end)
  end

  defp covers([min_a, max_a], [min_b, max_b]) do
    min_a <= min_b && max_a >= max_b
  end

  defp overlaps([min_a, max_a], [min_b, max_b]) do
    max_a >= min_b && max_a <= max_b ||
      min_a <= max_b && min_a >= min_b ||
        covers([min_a, max_a], [min_b, max_b])
  end
end
