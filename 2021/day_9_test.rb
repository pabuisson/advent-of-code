# frozen_string_literal: true

require './test_helper'
require './day_9'

class Day9Test < MiniTest::Test
  DATA = <<~TEXT
    2199943210
    3987894921
    9856789892
    8767896789
    9899965678
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_15_danger_score_for_part_1
    assert_equal 15, Day9.new(io: @data).compute_part_1!
  end

  def test_returns_1134_three_largest_basin_sizes_multiplied
    assert_equal 1_134, Day9.new(io: @data).compute_part_2!
  end
end
