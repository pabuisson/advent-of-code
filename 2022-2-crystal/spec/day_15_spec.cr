require "./spec_helper"
require "../src/day_15.cr"

describe Aoc2022::Day15 do
  # describe "part 1" do
  #   it "test data" do
  #     test_data = File.read("./data/day_15_test.txt")
  #     result = Aoc2022::Day15.part_1(input: test_data, line: 10, log: true)
  #     result.should eq 26
  #   end

  #   it "real data" do
  #     real_data = File.read("./data/day_15.txt")
  #     result = Aoc2022::Day15.part_1(input: real_data, line: 2_000_000)
  #     result.should be_truthy
  #     result.should eq 58_09_294
  #   end
  # end

  describe "part 2", focus: true  do
    it "test data" do
      test_data = File.read("./data/day_15_test.txt")
      result = Aoc2022::Day15.part_2(input: test_data, max_x_and_y: 20)
      result.should eq 56_000_011
    end

    it "real data" do
      real_data = File.read("./data/day_15.txt")
      result = Aoc2022::Day15.part_2(input: real_data, max_x_and_y: 4_000_000)
      result.should be_truthy
      result.should eq 10_693_731_308_112
    end
  end

  describe "#reduce_ranges", focus: true do
    it "returns one range if there one range that covers all" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(5..15), (0..20)])
      result.should eq [(0..20)]
    end

    it "removes fully overlapping ranges" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(5..15), (2..18)])
      result.should eq [(2..18)]
    end

    it "merges partially overlapping ranges" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(5..15), (10..20)])
      result.should eq [(5..20)]
    end

    it "merges partially overlapping ranges with same begin" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(2..2), (2..10), (2..3)])
      result.should eq [(2..10)]
    end

    it "clips ranges that start before the min" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(-5..5), (15..20)])
      result.should eq [(0..5), (15..20)]
    end

    it "clips ranges that finish after the max" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(5..10), (15..25)])
      result.should eq [(5..10), (15..20)]
    end

    it "clips and merges overlapping ranges" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(-5..10), (5..15)])
      result.should eq [(0..15)]

      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [(5..15), (10..25)])
      result.should eq [(5..20)]
    end

    it "merges neighbour ranges" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [-4..8, 9..9, 9..11, 9..19, 11..13, 14..20, 15..25])
      result.should eq [(0..20)]
    end

    it "real case 1" do
      result = Aoc2022::Day15.reduce_ranges(min: 0, max: 20, ranges: [-2..2, 2..14, 2..2, 12..12, 14..18, 16..24])
      result.should eq [(0..20)]
    end
  end

  describe Aoc2022::Day15::Sensor do
    describe "#coverage" do
      it "returns an array of Ranges representing the coverage" do
        sensor = Aoc2022::Day15::Sensor.new(
          position: Aoc2022::Day15::Position.new(x: 8, y: 7),
          beacon_position: Aoc2022::Day15::Position.new(x: 2, y: 10)
        )

        result = sensor.coverage
        result.values.size.should eq 19
        result.should eq ({
                        -2 => (8..8),
                        -1 => (7..9),
                        0 => (6..10),
                        1 => (5..11),
                        2 => (4..12),
                        3 => (3..13),
                        4 => (2..14),
                        5 => (1..15),
                        6 => (0..16),
                        7 => (-1..17),
                        8 => (0..16),
                        9 => (1..15),
                        10 => (2..14),
                        11 => (3..13),
                        12 => (4..12),
                        13 => (5..11),
                        14 => (6..10),
                        15 => (7..9),
                        16 => (8..8)
                        })
      end
    end
  end

end
