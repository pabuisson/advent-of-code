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
