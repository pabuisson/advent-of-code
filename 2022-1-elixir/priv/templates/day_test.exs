defmodule <%= module_name %>Test do
  use ExUnit.Case

  setup_all do
    IO.puts("--- DAY <%= day %> ----")
    {:ok, test_data} = File.read("data/day_<%= day %>_test.txt")
    {:ok, real_data} = File.read("data/day_<%= day %>.txt")
    {:ok, test_data: test_data, real_data: real_data}
  end

  describe "part 1" do
    test "test data", context do
      test_result = <%= module_name %>.part_1(context[:test_data])
      IO.puts("part 1 :: test : #{test_result}")
      assert test_result == :ok
    end

    @tag :skip
    test "real data", context do
      real_result = <%= module_name %>.part_1(context[:real_data])
      IO.puts("part 1 :: real : #{real_result}")
      assert real_result
    end
  end

  describe "part 2" do
    @tag :skip
    test "test data", context do
      test_result = <%= module_name %>.part_2(context[:test_data])
      IO.puts("part 2 :: test : #{test_result}")
      assert test_result == :ok
    end

    @tag :skip
    test "real data", context do
      real_result = <%= module_name %>.part_2(context[:real_data])
      IO.puts("part 2 :: real : #{real_result}")
      assert real_result
    end
  end
end
