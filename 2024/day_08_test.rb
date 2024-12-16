# frozen_string_literal: true

require './test_helper'
require './day_08'

describe Day08 do
  before do
    @data = StringIO.new(<<~TEXT)
    ............
    ........0...
    .....0......
    .......0....
    ....0.......
    ......A.....
    ............
    ............
    ........A...
    .........A..
    ............
    ............
    TEXT
  end

  describe 'part 1' do
    it 'returns 14 antinodes for part 1' do
      assert_equal 14, Day08.new(io: @data).part_1!
    end

    describe 'antinode_positions' do
      it 'returns expected values for NO-SE ╲ positions' do
        p1 = Day08::Position.new(line: 2, col: 4)
        p2 = Day08::Position.new(line: 4, col: 7)
        expected = [
          Day08::Position.new(line: 0, col: 1),
          Day08::Position.new(line: 6, col: 10),
        ]

        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p1, p2)

        @data.rewind
        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p2, p1)
      end

      it 'returns expected values for SO-NE ╱ positions' do
        p1 = Day08::Position.new(line: 4, col: 3)
        p2 = Day08::Position.new(line: 3, col: 6)
        expected = [
          Day08::Position.new(line: 5, col: 0),
          Day08::Position.new(line: 2, col: 9),
        ]

        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p1, p2)

        @data.rewind
        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p2, p1)
      end

      it 'returns expected values for vertical positions' do
        p1 = Day08::Position.new(line: 3, col: 1)
        p2 = Day08::Position.new(line: 4, col: 1)
        expected = [
          Day08::Position.new(line: 2, col: 1),
          Day08::Position.new(line: 5, col: 1),
        ]

        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p1, p2)

        @data.rewind
        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p2, p1)
      end

      it 'returns expected values for horizontal positions' do
        p1 = Day08::Position.new(line: 4, col: 3)
        p2 = Day08::Position.new(line: 4, col: 5)
        expected = [
          Day08::Position.new(line: 4, col: 1),
          Day08::Position.new(line: 4, col: 7),
        ]

        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p1, p2)

        @data.rewind
        assert_same_arrays expected, Day08::Map.new(@data).antinode_positions(p2, p1)
      end

      it 'does not return values that are outside the map' do
        p1 = Day08::Position.new(line: 0, col: 0)
        p2 = Day08::Position.new(line: @data.size - 1, col: @data.first.size - 1)

        assert_same_arrays [], Day08::Map.new(@data).antinode_positions(p1, p2)

        @data.rewind
        assert_same_arrays [], Day08::Map.new(@data).antinode_positions(p2, p1)
      end
    end
  end

  describe 'part 2' do
    it 'returns 34 antinodes for part 2' do
      assert_equal 34, Day08.new(io: @data).part_2!
    end
  end

  private

  def assert_same_arrays(expected, actual)
    assert_equal expected.size, actual.size, "arrays don't have the same number of items"
    assert_equal [], expected - actual, "arrays do not contain the same values.\nExpected = #{expected},\nActual = #{actual},\nDIFF = #{expected-actual}"
    assert_equal [], actual - expected, "arrays do not contain the same values.\nExpected = #{expected},\nActual = #{actual},\nDIFF = #{actual-expected}"
  end
end
