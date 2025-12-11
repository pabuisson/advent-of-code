require "./spec_helper"
require "../src/day_07"

# run this specific file with: crystal spec --tag 'day_07'

describe Day07, tags: "day_07" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_07_test.txt")
      Day07.part_1(test_data, must_log: true).should eq 21
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_07.txt")
      Day07.part_1(test_data, must_log: false).should eq 1_560
    end
  end

  describe "part 2" do
    it "works with example data", tags: "focus" do
      test_data = File.read_lines("./data/day_07_test.txt")
      Day07.part_2(test_data, must_log: false).should eq nil
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_07.txt")
      Day07.part_2(test_data, must_log: false).should eq nil
    end
  end
end
