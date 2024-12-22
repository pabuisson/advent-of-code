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
  end
end
