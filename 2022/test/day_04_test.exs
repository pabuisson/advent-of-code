defmodule Day04Test do
  use ExUnit.Case

  setup_all do
    IO.puts("--- DAY 04 ----")
    {:ok, test_data} = File.read("data/day_04_test.txt")
    {:ok, real_data} = File.read("data/day_04.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = Day04.part_1(context[:test_data])
      IO.puts("part 1 :: test : #{test_result}")
      assert test_result == 2
    end

    test "real data", context do
      real_result = Day04.part_1(context[:real_data])
      IO.puts("part 1 :: real : #{real_result}")
      assert real_result
    end
  end

  describe "part 2" do
    test "test data", context do
      test_result = Day04.part_2(context[:test_data])
      IO.puts("part 2 :: test : #{test_result}")
      assert test_result == 4
    end

    test "real data", context do
      real_result = Day04.part_2(context[:real_data])
      IO.puts("part 2 :: real : #{real_result}")
      assert real_result
    end
  end
end
