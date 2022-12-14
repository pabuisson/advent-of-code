require "./spec_helper"
require "../src/day_14.cr"

describe Aoc2022::Day14 do
  describe "part 1" do
    it "test data" do
      test_data = File.read("./data/day_14_test.txt")
      result = Aoc2022::Day14.part_1(input: test_data)
      result.should eq 24
    end

    it "real data" do
      real_data = File.read("./data/day_14.txt")
      result = Aoc2022::Day14.part_1(input: real_data)
      result.should be_truthy
      result.should eq 578
    end
  end

  describe "part 2" do
    it "test data" do
      test_data = File.read("./data/day_14_test.txt")
      result = Aoc2022::Day14.part_2(input: test_data)
      result.should eq 93
    end

    it "real data" do
      real_data = File.read("./data/day_14.txt")
      result = Aoc2022::Day14.part_2(input: real_data)
      result.should be_truthy
      result.should eq 24_377
    end
  end
end
