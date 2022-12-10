require "./spec_helper"
require "../src/day_09.cr"

describe Aoc2022::Day09 do
  describe "part 1" do
    it "test data" do
      test_data = File.read("./data/day_09_test_part_1.txt")
      result = Aoc2022::Day09.part_1(input: test_data)
      result.should eq 13
    end

    it "real data" do
      real_data = File.read("./data/day_09.txt")
      result = Aoc2022::Day09.part_1(input: real_data)
      result.should be_truthy
      result.should eq 5_874
    end
  end

  describe "part 2", focus: true do
    it "test data" do
      test_data = File.read("./data/day_09_test_part_1.txt")
      result = Aoc2022::Day09.part_2(input: test_data)
      result.should eq 1

      test_data = File.read("./data/day_09_test_part_2.txt")
      result = Aoc2022::Day09.part_2(input: test_data)
      result.should eq 36
    end

    it "real data" do
      real_data = File.read("./data/day_09.txt")
      result = Aoc2022::Day09.part_2(input: real_data)
      result.should be_truthy
      result.should eq 2_467
    end
  end

  describe Aoc2022::Day09::Position do
    describe "adjacent?" do
      it "returns true for vertically and diagonally adjacent" do
        from = Aoc2022::Day09::Position.new(x: 1, y: 1)

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 2, y: 1))
        result.should be_true

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 1, y: 2))
        result.should be_true

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 2, y: 2))
        result.should be_true

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 1, y: 1))
        result.should be_true
      end

      it "returns true even with negative and positive values" do
        from = Aoc2022::Day09::Position.new(x: 0, y: 0)

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: -1, y: 0))
        result.should be_true

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 0, y: -1))
        result.should be_true

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: -1, y: -1))
        result.should be_true
      end

      it "returns false if more than 1 of difference" do
        from = Aoc2022::Day09::Position.new(x: 1, y: 1)

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 3, y: 1))
        result.should be_false

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: 1, y: 3))
        result.should be_false
      end

      it "returns false with negative and positive values" do
        from = Aoc2022::Day09::Position.new(x: 0, y: 1)

        result = from.adjacent?(to: Aoc2022::Day09::Position.new(x: -2, y: 2))
        result.should be_false
      end
    end
  end

  describe Aoc2022::Day09::Move do
    describe "#decompose" do
      it "returns an array of 1 for a 1-distance move" do
        move = Aoc2022::Day09::Move.new(direction: "U", distance: 1)
        move.decompose.should eq [Aoc2022::Day09::Move.new(direction: "U", distance: 1)]
      end

      it "returns an array of n for a multiple-distance move" do
        move = Aoc2022::Day09::Move.new(direction: "U", distance: 4)
        move.decompose.should eq [
          Aoc2022::Day09::Move.new(direction: "U", distance: 1),
          Aoc2022::Day09::Move.new(direction: "U", distance: 1),
          Aoc2022::Day09::Move.new(direction: "U", distance: 1),
          Aoc2022::Day09::Move.new(direction: "U", distance: 1)
        ]
      end
    end
  end
end
