require "./spec_helper"
require "../src/day_02"

# run this specific file with: crystal spec --tag 'day_02'

describe Day02, tags: "day_02" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_02_test.txt")
      Day02.part_1(test_data).should eq 1_227_775_554
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_02.txt")
      Day02.part_1(test_data).should eq 37_314_786_486
    end
  end

  describe "part 2" do
    it "works with example data", tags: "focus" do
      test_data = File.read_lines("./data/day_02_test.txt")
      Day02.part_2(test_data).should eq 4_174_379_265
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_02.txt")
      Day02.part_2(test_data).should eq 47_477_053_982
    end
  end
end
