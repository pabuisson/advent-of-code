require "./spec_helper"
require "../src/day_03"

# run this specific file with: crystal spec --tag 'day_03'

describe Day03, tags: "day_03" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_03_test.txt")
      Day03.part_1(test_data, must_log: false).should eq (98 + 89 + 78 + 92)
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_03.txt")
      Day03.part_1(test_data, must_log: false).should eq 17_074
    end
  end

  describe "part 2" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_03_test.txt")
      Day03.part_2(test_data, must_log: false).should eq 3_121_910_778_619
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_03.txt")
      Day03.part_2(test_data).should eq 169_512_729_575_727
    end
  end
end
