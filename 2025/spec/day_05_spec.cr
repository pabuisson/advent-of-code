require "./spec_helper"
require "../src/day_05"

# run this specific file with: crystal spec --tag 'day_05'

describe Day05, tags: "day_05" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_05_test.txt")
      Day05.part_1(test_data, must_log: false).should eq 3
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_05.txt")
      Day05.part_1(test_data, must_log: false).should eq 828
    end
  end

  describe "part 2" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_05_test.txt")
      Day05.part_2(test_data, must_log: false).should eq 14
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_05.txt")
      Day05.part_2(test_data).should eq nil
    end
  end
end
