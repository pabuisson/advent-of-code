defmodule Day03Test do
  use ExUnit.Case

  setup_all do
    IO.puts("--- DAY 03 ----")
    {:ok, test_data} = File.read("data/day_03_part_01_test.txt")
    {:ok, real_data} = File.read("data/day_03_part_01.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = Day03.part_1(context[:test_data])
      IO.puts("1/ test input: #{test_result}")
      assert test_result == 157
    end

    test "real data", context do
      real_result = Day03.part_1(context[:real_data])
      IO.puts("1/ real input: #{real_result}")
      assert real_result
    end
  end

  describe "part 2" do
    test "test data", context do
      test_result = Day03.part_2(context[:test_data])
      IO.puts("2/ test input: #{test_result}")
      assert test_result == 70
    end

    test "real data", context do
      real_result = Day03.part_2(context[:real_data])
      IO.puts("2/ real input: #{real_result}")
      assert real_result
    end
  end
end
