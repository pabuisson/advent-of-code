# frozen_string_literal: true

require './test_helper'
require './day_09'

describe Day09 do
  before do
    @data = StringIO.new("2333133121414131402")
  end

  describe 'part 1' do
    it 'returns 1928 for part 1' do
      Day09.new(io: @data).part_1! => {result:}
      assert_equal 1_928, result
    end

    it 'repacks the blocks correctly' do
      Day09.new(io: @data).part_1! => {repacked:}
      assert_equal '0099811188827773336446555566', repacked
    end
  end

  describe 'part 2' do
    it 'returns 2858 for part 2' do
      assert_equal 2_858, Day09.new(io: @data).part_2!
    end
  end
end
