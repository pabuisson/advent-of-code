defmodule Day07 do
  def part_1(input) do
    input
    |> format
    |> Enum.filter(fn(size) -> size <= 100_000 end)
    |> Enum.sum
  end

  def part_2(input) do
    biggest_directory_size =
      input
      |> format
      |> Enum.max

    free_space = 70_000_000 - biggest_directory_size
    required_space = 30_000_000

    input
    |> format
    |> Enum.filter(fn(size) -> free_space + size >= required_space end)
    |> Enum.min
  end

  defp format(input) do
    {size_and_parents, _} =
      input
      |> String.split("\n")
      |> Enum.map_reduce([], fn(line, parents) ->
        cond do
          cd?(line) -> { nil, [cd_target(line) | parents] }
          cd_back?(line) -> { nil, tl(parents) }
          file?(line) -> { %{ size: get_file_size(line), parents: parents }, parents }
          true -> { nil, parents }
        end
      end)

    size_and_parents
    |> Enum.reject(&is_nil(&1))
    |> Enum.flat_map(fn(%{ size: size, parents: parents }) ->
      expand_parent_paths(parents)
      |> Enum.map(fn(parents) -> %{ parents: parents, size: size } end)
    end)
    |> Enum.group_by(fn(%{parents: parents}) -> parents end)
    |> Enum.map(fn({ _, files }) ->
      files
      |> Enum.map(fn(%{size: size}) -> size end)
      |> Enum.sum
    end)
  end

  def expand_parent_paths(parents) do
    { expanded_parents, _ } =
      parents
      |> Enum.map_reduce(parents, fn(_, acc) -> { acc, tl(acc) } end)

    expanded_parents
  end

  defp cd?(line), do: String.starts_with?(line, "$ cd") && !cd_back?(line)
  defp cd_back?(line), do: line == "$ cd .."
  defp file?(line), do: String.match?(line, ~r/^\d+ [\w\.]+$/)
  defp cd_target(line), do: String.replace(line, "$ cd ", "")
  defp get_file_size(line) do
    [size, _] = line |> String.split(" ")
    String.to_integer(size)
  end
end
