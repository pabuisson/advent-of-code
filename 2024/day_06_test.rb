# frozen_string_literal: true

require './test_helper'
require './day_06'

describe Day06 do
  before do
    @data = StringIO.new(<<~TEXT)
      ....#.....
      .........#
      ..........
      ..#.......
      .......#..
      ..........
      .#..^.....
      ........#.
      #.........
      ......#...
    TEXT
  end

  it 'returns 41 for part 1' do
    assert_equal 41, Day06.new(io: @data).part_1!
  end

  it 'returns 6 possible obstacle that would create a loop for part 2' do
    assert_equal 6, Day06.new(io: @data).part_2!
  end
end
