require "./spec_helper"
require "../src/day_13.cr"

describe Aoc2022::Day13, focus: true do
  describe "part 1" do
    # it "test data" do
    #   test_data = File.read("./data/day_13_test.txt")
    #   result = Aoc2022::Day13.part_1(input: test_data, log: false)
    #   result.should eq 13
    # end

    # it "real data" do
    #   real_data = File.read("./data/day_13.txt")
    #   result = Aoc2022::Day13.part_1(input: real_data, log: false)
    #   result.should be_truthy
    #   result.should eq 182_293
    # end
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
          result.should eq 1
        end

        it "returns 0 if not in right order" do
          result = Aoc2022::Day13::Pair.new("[1, 5, 3]", "[1, 3, 4]").right_order?
          result.should eq 0
        end
      end

      describe "one-level nested array" do
        it "returns 1 if sub-array in right order" do
          result = Aoc2022::Day13::Pair.new("[1, [2, 3]]", "[1, [3, 4]]").right_order?
          result.should eq 1
        end

        it "returns 0 if sub-array not in right order" do
          result = Aoc2022::Day13::Pair.new("[1, [2, 3]]", "[1, [2, 4]]").right_order?
          result.should eq 0
        end
      end
    end
  end
end
