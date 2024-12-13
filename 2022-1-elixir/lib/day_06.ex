defmodule Day06 do

  def part_1(input) do
    section_size = 4
    first_marker_index =
      input
      |> String.codepoints
      |> Enum.chunk_every(section_size, 1)
      |> Enum.find_index(&has_no_repeating_chars(&1))

    first_marker_index + section_size
  end

  def part_2(input) do
    section_size = 14
    first_message_index =
      input
      |> String.codepoints
      |> Enum.chunk_every(section_size, 1)
      |> Enum.find_index(&has_no_repeating_chars(&1))

    first_message_index + section_size
  end

  defp has_no_repeating_chars(chars) do
    Enum.count(chars) == (chars |> Enum.uniq |> Enum.count)
  end
end
