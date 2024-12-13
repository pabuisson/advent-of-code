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
end
