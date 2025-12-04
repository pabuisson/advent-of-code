require "./spec_helper"
require "../src/day_04"

# run this specific file with: crystal spec --tag 'day_04'

describe Day04, tags: "day_04" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_04_test.txt")
      Day04.part_1(test_data, must_log: false).should eq nil
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_04.txt")
      Day04.part_1(test_data, must_log: false).should eq nil
    end
  end

  describe "part 2" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_04_test.txt")
      Day04.part_2(test_data, must_log: false).should eq nil
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_04.txt")
      Day04.part_2(test_data).should eq nil
    end
  end
end
