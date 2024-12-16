# frozen_string_literal: true

require './test_helper'
require './day_07'

describe Day07 do
  before do
    @data = StringIO.new(<<~TEXT)
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    TEXT
  end

  it 'returns 3_749 for part 1' do
    assert_equal 3_749, Day07.new(io: @data).part_1!
  end

  it 'returns 11_387 for part 2' do
    assert_equal 11_387, Day07.new(io: @data).part_2!
  end
end
