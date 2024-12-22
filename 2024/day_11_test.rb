# frozen_string_literal: true

require './test_helper'
require './day_11'

describe Day11 do
  before do
    @small = StringIO.new("0 1 10 99 999")
    @longer = StringIO.new("125 17")
  end

  it 'returns expected disposition for simple example after one blink' do
    Day11.new(io: @small).part_1!(blinks_count: 1) => {blinks:}
    assert_equal 7, blinks[0]
  end

  it 'returns expected disposition for more complex example after six first blinks' do
    Day11.new(io: @longer).part_1!(blinks_count: 25) => {blinks:}

    assert_equal 22, blinks[5]
    assert_equal 55_312, blinks[24]
  end

  # it 'returns 81 for part 2' do
  #   Day11.new(io: @large).part_2! => {trailheads_count: 9, result:}
  #   assert_equal 81, result
  # end
end
