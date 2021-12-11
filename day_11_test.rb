# frozen_string_literal: true

require 'minitest/autorun'
require './day_11'

class Day11Test < MiniTest::Test
  DATA = <<~TEXT
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_1656_flashes_after_step_100
    assert_equal 1_656, Day11.new(io: @data).compute_part_1!
  end

  def test_returns_288957_final_score_for_the_5_incomplete_lines
    assert false
  end
end
