defmodule Day07Test do
  use ExUnit.Case

  setup_all do
    IO.puts("--- DAY 07 ----")
    {:ok, test_data} = File.read("data/day_07_test.txt")
    {:ok, real_data} = File.read("data/day_07.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = Day07.part_1(context[:test_data])
      IO.puts("part 1 :: test : #{test_result}")
      assert test_result == 95_437
    end

    test "real data", context do
      real_result = Day07.part_1(context[:real_data])
      IO.puts("part 1 :: real : #{real_result}")
      assert real_result
      assert real_result == 1_084_134
    end
  end

  describe "part 2" do
    test "test data", context do
      test_result = Day07.part_2(context[:test_data])
      IO.puts("part 2 :: test : #{test_result}")
      assert test_result == 24_933_642
    end

    test "real data", context do
      real_result = Day07.part_2(context[:real_data])
      IO.puts("part 2 :: real : #{real_result}")
      assert real_result
      assert real_result == 6_183_184
    end
  end
end
