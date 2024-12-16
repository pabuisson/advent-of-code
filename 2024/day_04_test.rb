# frozen_string_literal: true

require './test_helper'
require './day_04'

describe Day04 do
  before do
    @data = StringIO.new(<<~TEXT)
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    TEXT
  end

  it 'returns 18 for part 1' do
    assert_equal 18, Day04.new(io: @data).part_1!
  end

  it 'returns 9 for part 2' do
    assert_equal 9, Day04.new(io: @data).part_2!
  end
end
