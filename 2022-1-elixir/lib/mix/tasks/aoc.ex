defmodule Mix.Tasks.Aoc.Gen do
  @moduledoc "The aoc.gen mix task: `mix help aoc.gen`"
  use Mix.Task

  @shortdoc "Creates all required files for a given day"

  def run([]) do
    IO.puts(:stderr, "This mix task must be called with the day")
    IO.puts(:stderr, "$ mix aoc.gen 14")
  end

  def run([day]) do
    context = [
      day: day,
      module_name: "Day#{day}"
    ]

    Mix.Generator.create_file(
      "lib/day_#{day}.ex",
      EEx.eval_file("priv/templates/day.ex", context)
    )
    Mix.Generator.create_file(
      "test/day_#{day}_test.exs",
      EEx.eval_file("priv/templates/day_test.exs", context)
    )
    Mix.Generator.copy_file("priv/templates/data_test.txt", "data/day_#{day}_test.txt")
    Mix.Generator.copy_file("priv/templates/data.txt", "data/day_#{day}.txt")
  end

end
