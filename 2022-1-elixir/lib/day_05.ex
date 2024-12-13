defmodule Day05 do
  def part_1(input) do
    [initial_stacks, moves] = input |> format
    moves
    |> Enum.reduce(initial_stacks, fn(%{move: number_of_crates_to_move, from_index: from_index} = current_move, stacks) ->
      Enum.reduce(1..number_of_crates_to_move, stacks, fn(_, stacks) ->
        stacks
        |> Enum.with_index
        |> Enum.map(fn({current_stack, current_index}) ->
          source_stack = Enum.at(stacks, from_index)
          move_one_by_one(current_stack, current_index, source_stack, current_move)
        end)
      end)
    end)
    |> Enum.map(&hd(&1))
    |> List.to_string
  end

  defp move_one_by_one(current_stack, current_index, source_stack, %{from_index: from_index, to_index: target_index}) do
    cond do
      current_index == from_index -> tl(current_stack)
      current_index == target_index -> [hd(source_stack) | current_stack]
      true -> current_stack
    end
  end

  def part_2(input) do
    [initial_stacks, moves] = input |> format
    moves
    |> Enum.reduce(initial_stacks, fn(%{from_index: from_index} = current_move, stacks) ->
      stacks
      |> Enum.with_index
      |> Enum.map(fn({current_stack, current_index}) ->
          source_stack = Enum.at(stacks, from_index)
          move_in_batches(current_stack, current_index, source_stack, current_move)
      end)
    end)
    |> Enum.map(&hd(&1))
    |> List.to_string
  end

  defp move_in_batches(current_stack, current_index, source_stack, %{move: number_of_crates_to_move, from_index: from_index, to_index: target_index}) do
    cond do
      current_index == from_index -> remove_first_elements(current_stack, number_of_crates_to_move)
      current_index == target_index ->
        crates_to_move = Enum.take(source_stack, number_of_crates_to_move)
        crates_to_move ++ current_stack
      true -> current_stack
    end
  end

  defp remove_first_elements(list, times), do: Enum.reduce(1..times, list, fn(_, acc) -> tl(acc) end)


  defp format(input) do
    [stack_lines, move_lines] = input |> String.split("\n\n")
    [format_stacks(stack_lines), format_moves(move_lines)]
  end

  defp format_stacks(raw_lines_string) do
    raw_lines_string
    |> String.split("\n", trim: true)
    |> Enum.reject(&String.match?(&1, ~r/\d/))
    |> Enum.reverse
    |> Enum.map(&String.codepoints(&1))
    |> Enum.map(&Enum.chunk_every(&1, 4))
    |> Enum.map(fn(chunks) ->
      chunks
      |> Enum.map(&meaningful_letter(&1))
    end)
    |> Enum.zip
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.map(fn(list_in_wrong_order_with_spaces) ->
      list_in_wrong_order_with_spaces
      |> reject_empty_chars
      |> Enum.reverse
    end)
  end

  def meaningful_letter(list_of_four_chars), do: Enum.at(list_of_four_chars, 1)
  def reject_empty_chars(list), do: Enum.reject(list, fn(c) -> c == " " end)

  defp format_moves(raw_lines_string) do
    move_regexp = ~r/^move\s(?<move>\d+)\sfrom\s(?<from>\d+)\sto\s(?<to>\d+)$/
    raw_lines_string
    |> String.split("\n", trim: true)
    |> Enum.map(&Regex.named_captures(move_regexp, &1))
    |> Enum.map(fn(%{"move" => move, "from" => from, "to" => to}) ->
      %{
        move: String.to_integer(move),
        from_index: String.to_integer(from) - 1,
        to_index: String.to_integer(to) - 1
      }
    end)
  end
end
