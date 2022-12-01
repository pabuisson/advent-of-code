# frozen_string_literal: true

require './test_helper'
require './day_15'

class Day15Test < MiniTest::Test
  DATA = <<~TEXT
    1163751742
    1381373672
    2136511328
    3694931569
    7463417111
    1319128137
    1359912421
    3125421639
    1293138521
    2311944581
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_less_risky_path_of_40
    skip
    assert_equal 40, Day15.new(io: @data).compute_part_1!
  end

  def test_returns_2188189693529_after_40_steps
    assert_equal 315, Day15.new(io: @data).compute_part_2!
  end
end
