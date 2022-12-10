require "./spec_helper"
require "../src/day_10.cr"

describe Aoc2022::Day10, focus: true do
  describe "part 1" do
    it "test data" do
      test_data = File.read("./data/day_10_test.txt")
      result = Aoc2022::Day10.part_1(input: test_data)
      result.should eq 13_140
    end

    it "real data" do
      real_data = File.read("./data/day_10.txt")
      result = Aoc2022::Day10.part_1(input: real_data)
      result.should be_truthy
      result.should eq 14_060
    end
  end

  describe "part 2" do
    it "test data" do
      test_data = File.read("./data/day_10_test.txt")
      expected = [
        "##..##..##..##..##..##..##..##..##..##..",
        "###...###...###...###...###...###...###.",
        "####....####....####....####....####....",
        "#####.....#####.....#####.....#####.....",
        "######......######......######......####",
        "#######.......#######.......#######....."
      ]

      result = Aoc2022::Day10.part_2(input: test_data)
      (0..5).each { |row| result[row].should eq expected[row] }
    end

    it "real data" do
      real_data = File.read("./data/day_10.txt")
      expected = [
        "###...##..###..#..#.####.#..#.####...##.",
        "#..#.#..#.#..#.#.#..#....#.#..#.......#.",
        "#..#.#..#.#..#.##...###..##...###.....#.",
        "###..####.###..#.#..#....#.#..#.......#.",
        "#....#..#.#....#.#..#....#.#..#....#..#.",
        "#....#..#.#....#..#.#....#..#.####..##.."
      ]

      result = Aoc2022::Day10.part_2(input: real_data)
      (0..5).each { |row| result[row].should eq expected[row] }
    end
  end
end
