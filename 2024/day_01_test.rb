# frozen_string_literal: true

require './test_helper'
require './day_01'

describe Day01 do
  before do
    @data = StringIO.new(<<~TEXT)
      3   4
      4   3
      2   5
      1   3
      3   9
      3   3 
    TEXT
  end

  it 'returns_11_for_part_1' do
    assert_equal 11, Day01.new(io: @data).part_1!
  end

  it 'returns_31_for_part_2' do
    assert_equal 31, Day01.new(io: @data).part_2!
  end
end
