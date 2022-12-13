require "./spec_helper"
require "../src/day_13.cr"

describe Aoc2022::Day13 do
  describe "part 1" do
    it "test data" do
      test_data = File.read("./data/day_13_test.txt")
      result = Aoc2022::Day13.part_1(input: test_data, log: false)
      result.should eq 13
    end

    it "real data" do
      real_data = File.read("./data/day_13.txt")
      result = Aoc2022::Day13.part_1(input: real_data, log: false)
      puts "result: #{result}"
      result.should be_truthy
      # NOTE: all these results below made all tests pass and seem somehow to make sense
      # but they're not the exepected result for the test input...
      # result.should eq 410
      # result.should eq 679
      # result.should eq 6118
      # result.should eq 5021
    end
  end

  # describe "part 2" do
  #   it "test data" do
  #     test_data = File.read("./data/day_13_test.txt")
  #     result = Aoc2022::Day13.part_2(input: test_data)
  #     result.should eq 2_713_310_158
  #   end

  #   it "real data" do
  #     real_data = File.read("./data/day_13.txt")
  #     result = Aoc2022::Day13.part_2(input: real_data)
  #     result.should be_truthy
  #     result.should eq 54_832_778_815
  #   end
  # end

  describe Aoc2022::Day13::Pair do
    describe "#right_order?" do
      describe "flat array" do
        it "returns 1 if in right order" do
          result = Aoc2022::Day13::Pair.new("[1, 2, 3]", "[2, 3, 4]").right_order?
          result.should be_true
        end

        it "returns 0 if not in right order" do
          result = Aoc2022::Day13::Pair.new("[1, 5, 3]", "[1, 3, 4]").right_order?
          result.should be_false
        end
      end

      describe "one-level nested array" do
        it "returns 1 if sub-array in right order" do
          result = Aoc2022::Day13::Pair.new("[1, [2, 3]]", "[1, [3, 4]]").right_order?
          result.should be_true
        end

        it "returns 0 if sub-array not in right order" do
          result = Aoc2022::Day13::Pair.new("[1, [2, 4]]", "[1, [2, 3]]").right_order?
          result.should be_false
        end
      end

      describe "multiple-level nested array" do
        it "returns 1 if sub-array in right order" do
          result = Aoc2022::Day13::Pair.new("[1, [2, [3]]]", "[1, [2, [4]]]").right_order?
          result.should be_true
        end

        it "returns 0 if sub-array not in right order" do
          result = Aoc2022::Day13::Pair.new("[1, [2, [4]]]", "[1, [2, [3]]]").right_order?
          result.should be_false
        end
      end

      describe "works for examples from the exercice" do
        it "example 1" do
          result = Aoc2022::Day13::Pair.new("[1, 1, 3, 1, 1]", "[1, 1, 5, 1, 1]").right_order?
          result.should be_true
        end

        it "example 2" do
          result = Aoc2022::Day13::Pair.new("[[1], [2, 3, 4]]", "[[1], 4]").right_order?
          result.should be_true
        end

        it "example 3" do
          result = Aoc2022::Day13::Pair.new("[9]", "[[8, 7, 6]]").right_order?
          result.should be_false
        end

        it "example 4" do
          result = Aoc2022::Day13::Pair.new("[[4, 4], 4, 4]", "[[4, 4], 4, 4, 4]").right_order?
          result.should be_true
        end

        it "example 5" do
          result = Aoc2022::Day13::Pair.new("[7, 7, 7, 7]", "[7, 7, 7]").right_order?
          result.should be_false
        end

        it "example 6" do
          result = Aoc2022::Day13::Pair.new("[]", "[3]").right_order?
          result.should be_true
        end

        it "example 7" do
          result = Aoc2022::Day13::Pair.new("[[[]]]", "[[]]").right_order?
          result.should be_false
        end

        it "example 8" do
          result = Aoc2022::Day13::Pair.new("[1,[2,[3,[4,[5,6,7]]]],8,9]", "[1,[2,[3,[4,[5,6,0]]]],8,9]").right_order?
          result.should be_false
        end
      end
    end
  end
end
