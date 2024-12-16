# frozen_string_literal: true

require './test_helper'
require './day_02'


describe Day02 do
  before do
    @data = StringIO.new(<<~TEXT)
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    TEXT
  end

  it 'returns 2 safe reports for part 1' do
    assert_equal 2, Day02.new(io: @data).part_1!
  end

  it 'returns 4 safe reports for part 2 with problem dampener' do
    assert_equal 4, Day02.new(io: @data).part_2!
  end

  # Some specific cases

  it 'return 0 for a report where more than two levels have same value' do
    data = StringIO.new(<<~TEXT)
    6 8 9 9 10 10
    6 8 9 9 9 10
    TEXT

    assert_equal 0, Day02.new(io: data).part_2!
  end

  it 'return 1 for a report where last level is invalid' do
    data = StringIO.new([6, 8, 9, 11, 10].join(' '))
    assert_equal 1, Day02.new(io: data).part_2!
  end

  it 'return 0 for a report where last two levels are invalid' do
    data = StringIO.new([6, 8, 1, 9, 11, 16].join(' '))
    assert_equal 0, Day02.new(io: data).part_2!
  end

  it 'returns 1 for a report where first level is invalid' do
    data = StringIO.new([3, 8, 9, 10, 11].join(' '))
    assert_equal 1, Day02.new(io: data).part_2!
  end

  it 'return 0 for a report where two levels are invalid' do
    data = StringIO.new([6, 8, 14, 10, 11, 17, 12, 13].join(' '))
    assert_equal 0, Day02.new(io: data).part_2!
  end
end
