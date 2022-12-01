# frozen_string_literal: true

require './test_helper'
require './day_13'

class Day12Test < MiniTest::Test
  DATA = <<~TEXT
    6,10
    0,14
    9,10
    0,3
    10,4
    4,11
    6,0
    6,12
    4,1
    0,13
    10,12
    3,4
    3,0
    8,4
    1,10
    2,14
    8,10
    9,0

    fold along y=7
    fold along x=5
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_17_dots_after_first_fold
    assert_equal 17, Day13.new(io: @data).compute_part_1!
  end

  def test_returns_16_dots_after_all_folds
    assert_equal 16, Day13.new(io: @data).compute_part_2!
  end
end
