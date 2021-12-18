# frozen_string_literal: true

require './test_helper'
require './day_3'

class Day3Test < MiniTest::Test
  DATA = <<~TEXT
    00100
    11110
    10110
    10111
    10101
    01111
    00111
    11100
    10000
    11001
    00010
    01010
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_198_for_part_1
    assert_equal 198, Day3.new(io: @data).compute_part_1!
  end

  def test_returns_230_for_part_2
    assert_equal 230, Day3.new(io: @data).compute_part_2!
  end
end
