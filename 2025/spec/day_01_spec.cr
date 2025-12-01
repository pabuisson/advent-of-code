require "./spec_helper"
require "../src/day_01"

# run this specific file with: crystal spec --tag 'day_01'

describe Day01, tags: "day_01" do
  describe "part 1" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_01_test.txt")
      Day01.part_1(test_data).should eq 3
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_01.txt")
      Day01.part_1(test_data).should eq 1064
    end

    describe "move" do
      it "crossed zero one time when new_value is 0" do
        expected = {crossed_zero: 1, new_value: 0}
        Day01::Move.new("L5").apply_to(5, part: Day01::Part::One).should eq expected
      end

      it "did not cross zero when new_value is not exactly 0" do
        expected = {crossed_zero: 0, new_value: 95}
        Day01::Move.new("L10").apply_to(5, part: Day01::Part::One).should eq expected
      end
    end
  end

  describe "part 2" do
    it "works with example data" do
      test_data = File.read_lines("./data/day_01_test.txt")
      Day01.part_2(test_data, must_log: false).should eq 6
    end

    it "works with normal data" do
      test_data = File.read_lines("./data/day_01.txt")
      Day01.part_2(test_data, must_log: false).should eq 6_122
    end

    describe "move" do
      describe "move left" do
        it "crossed zero once when new_value is 0" do
          expected = {crossed_zero: 1, new_value: 0}
          Day01::Move.new("L5").apply_to(5, part: Day01::Part::Two).should eq expected
        end

        it "crossed zero once" do
          expected = {crossed_zero: 1, new_value: 95}
          Day01::Move.new("L10").apply_to(5, part: Day01::Part::Two).should eq expected
        end

        it "crossed zero multiple times" do
          expected = {crossed_zero: 2, new_value: 95}
          Day01::Move.new("L110").apply_to(5, part: Day01::Part::Two).should eq expected
        end
      end

      describe "move right" do
        it "crossed zero once when new_value is 0" do
          expected = {crossed_zero: 1, new_value: 0}
          Day01::Move.new("R5").apply_to(95, part: Day01::Part::Two).should eq expected
        end

        it "crossed zero once" do
          expected = {crossed_zero: 1, new_value: 5}
          Day01::Move.new("R10").apply_to(95, part: Day01::Part::Two).should eq expected
        end

        it "crossed zero multiple times" do
          expected = {crossed_zero: 2, new_value: 5}
          Day01::Move.new("R110").apply_to(95, part: Day01::Part::Two).should eq expected
        end
      end
    end
  end
end
