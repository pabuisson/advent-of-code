defmodule Day06Test do
  use ExUnit.Case

  setup_all do
    IO.puts("--- DAY 06 ----")
    {:ok, real_data} = File.read("data/day_06.txt")
    {:ok, real_data: real_data}
  end

  describe "part 1" do
    test "test data" do
      assert Day06.part_1("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
      assert Day06.part_1("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
      assert Day06.part_1("nppdvjthqldpwncqszvftbrmjlhg") == 6
      assert Day06.part_1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
      assert Day06.part_1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
    end

    test "real data", context do
      real_result = Day06.part_1(context[:real_data])
      IO.puts("part 1 :: real : #{real_result}")
      assert real_result
      assert real_result == 1625
    end
  end

  describe "part 2" do
    test "test data" do
      assert Day06.part_2("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
      assert Day06.part_2("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
      assert Day06.part_2("nppdvjthqldpwncqszvftbrmjlhg") == 23
      assert Day06.part_2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
      assert Day06.part_2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
    end

    test "real data", context do
      real_result = Day06.part_2(context[:real_data])
      IO.puts("part 2 :: real : #{real_result}")
      assert real_result
      assert real_result == 2250
    end
  end
end
