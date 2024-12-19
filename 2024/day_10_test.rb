# frozen_string_literal: true

require './test_helper'
require './day_10'

describe Day10 do
  before do
    @small = StringIO.new(<<~TEXT)
    0123
    1234
    8765
    9876
    TEXT

    @large = StringIO.new(<<~TEXT)
    89010123
    78121874
    87430965
    96549874
    45678903
    32019012
    01329801
    10456732
    TEXT
  end

  it 'finds the expected number of trailheads' do
    Day10.new(io: @small).part_1! => {trailheads_count:}
    assert_equal 1, trailheads_count

    Day10.new(io: @large).part_1! => {trailheads_count:}
    assert_equal 9, trailheads_count
  end

  it 'returns 36 for part 1' do
    Day10.new(io: @large).part_1! => {trailheads_count: 9, result:}
    assert_equal 36, result
  end

  it 'returns 81 for part 2' do
    Day10.new(io: @large).part_2! => {trailheads_count: 9, result:}
    assert_equal 81, result
  end

  it 'returns 227 for part 2 weird example' do
    data = StringIO.new(<<~TEXT)
    012345
    123456
    234567
    345678
    416789
    567891
    TEXT

    Day10.new(io: data).part_2! => {trailheads_count: 1, result:}
    assert_equal 227, result
  end
end
