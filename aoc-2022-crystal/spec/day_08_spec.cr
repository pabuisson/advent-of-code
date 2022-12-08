require "./spec_helper"
require "../src/day_08.cr"

describe Aoc2022::Day08 do
  describe "part 1" do
    it "test data" do
      test_data = File.read("./data/day_08_test.txt")
      result = Aoc2022::Day08.part_1(input: test_data)
      result.should eq 21
    end

    it "real data" do
      real_data = File.read("./data/day_08.txt")
      result = Aoc2022::Day08.part_1(input: real_data)
      result.should be_truthy
      result.should eq 1835
    end
  end

  describe "part 2" do
    it "test data" do
      test_data = File.read("./data/day_08_test.txt")
      result = Aoc2022::Day08.part_2(input: test_data)
      result.should eq 8
    end

    it "real data" do
      real_data = File.read("./data/day_08.txt")
      result = Aoc2022::Day08.part_2(input: real_data)
      result.should be_truthy
      result.should eq 263670
    end
  end
end
