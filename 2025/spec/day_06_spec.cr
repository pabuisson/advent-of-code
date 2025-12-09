require "./spec_helper"
require "../src/day_06"

# run this specific file with: crystal spec --tag 'day_06'

describe Day06, tags: "day_06" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_06_test.txt")
      Day06.part_1(test_data, must_log: false).should eq 33210 + 490 + 4243455 + 401
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_06.txt")
      Day06.part_1(test_data, must_log: false).should eq 4_412_382_293_768
    end
  end

  describe "part 2" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_06_test.txt")
      Day06.part_2(test_data, must_log: false).should eq 1058 + 3253600 + 625 + 8544
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_06.txt")
      Day06.part_2(test_data, must_log: false).should eq 7_858_808_482_092
    end
  end
end
