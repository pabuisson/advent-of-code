# frozen_string_literal: true

require './test_helper'
require './day_12'

describe Day12 do
  before do
    @small = StringIO.new(<<~TEXT)
    AAAA
    BBCD
    BBCC
    EEEC
    TEXT

    @larger = StringIO.new(<<~TEXT)
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    TEXT
  end

  describe 'part 1' do
    focus
    it 'returns expected regions for small example' do
      Day12.new(io: @small).part_1! => {regions:, result:}

      {
        "A" => [4, 10],
        "B" => [4, 8],
        "C" => [4, 10],
        "D" => [1, 4],
        "E" => [3, 8]
      }.each do |letter, (area, perimeter)|
        region = regions.find{ _1.letter == letter }
        assert_equal area, region.area, "Expected area for region #{letter} to be #{area}, got #{region.area}"
        assert_equal perimeter, region.perimeter, "Expected perimeter for region #{letter} to be #{perimeter}, got #{region.perimeter}"
      end

      assert_equal 140, result
    end

    focus
    it 'returns expected regions for larger example' do
      Day12.new(io: @larger).part_1! => {regions:, result:}

      # Special case: 2 regions with the same letter
      i_regions = regions.select { _1.letter == 'I' }.sort_by(&:area)
      i_expected = [[4, 8], [14, 22]]
      assert_equal i_expected, i_regions.map { [_1.area, _1.perimeter] }

      # Special case: 2 regions with the same letter
      c_regions = regions.select { _1.letter == 'C' }.sort_by(&:area)
      c_expected = [[1, 4], [14, 28]]
      assert_equal c_expected, c_regions.map { [_1.area, _1.perimeter] }

      # Regular cases: regions with unique name
      {
        "R" => [12, 18],
        "F" => [10, 18],
        "V" => [13, 20],
        "J" => [11, 20],
        "E" => [13, 18],
        "M" => [5, 12],
        "S" => [3, 8]
      }.each do |letter, (area, perimeter)|
        region = regions.find{ _1.letter == letter }
        assert_equal area, region.area, "Expected area for region #{letter} to be #{area}, got #{region.area}"
        assert_equal perimeter, region.perimeter, "Expected perimeter for region #{letter} to be #{perimeter}, got #{region.perimeter}"
      end

      assert_equal 1_930, result
    end
  end

  describe 'part 2' do
    focus
    it 'returns the correct number of sides for small example' do
      Day12.new(io: @small).part_2! => {regions:, result:}

      {
        "A" => 4,
        "B" => 4,
        "C" => 8,
        "D" => 4,
        "E" => 4
      }.each do |letter, sides|
        region = regions.find{ _1.letter == letter }
        assert_equal sides, region.sides, "Expected sides for region #{letter} to be #{sides}, got #{region.sides}"
      end

      assert_equal 140, result
    end

    focus
    it 'returns the correct number of sides for larger example' do
      Day12.new(io: @larger).part_2! => {regions:, result:}

      # Special case: 2 regions with the same letter
      i_regions = regions.select { _1.letter == 'I' }.sort_by(&:area)
      assert_equal [4, 16], i_regions.map(&:sides)

      # Special case: 2 regions with the same letter
      c_regions = regions.select { _1.letter == 'C' }.sort_by(&:area)
      assert_equal [4, 22], c_regions.map(&:sides)

      # Regular cases: regions with unique name
      {
        "R" => 10,
        "F" => 12,
        "V" => 10,
        "J" => 12,
        "E" => 8,
        "M" => 6,
        "S" => 6
      }.each do |letter, sides|
        region = regions.find{ _1.letter == letter }
        assert_equal area, region.area, "Expected area for region #{letter} to be #{area}, got #{region.area}"
        assert_equal sides, region.sides, "Expected sides for region #{letter} to be #{sides}, got #{region.sides}"
      end

      assert_equal 1_206, result
    end

    focus
    it 'returns the correct result for a map with E shape' do
      data = StringIO.new(<<~TEXT)
      EEEEE
      EXXXX
      EEEEE
      EXXXX
      EEEEE
      TEXT

      Day12.new(io: data).part_2! => {regions:, result:}

      region = regions.find { _1.letter == 'E' }
      assert_equal 17, region.area
      assert_equal 12, region.sides

      assert_equal 236, result
    end

    # The B zones are adjacent diagonally
    focus
    it 'returns the correct result for a map with adjacent zones' do
      data = StringIO.new(<<~TEXT)
      AAAAAA
      AAABBA
      AAABBA
      ABBAAA
      ABBAAA
      AAAAAA
      TEXT

      Day12.new(io: data).part_2! => {regions:, result:}

      assert_equal 3, regions.count
      assert_equal 368, result
    end
  end
end
