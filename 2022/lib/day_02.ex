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
