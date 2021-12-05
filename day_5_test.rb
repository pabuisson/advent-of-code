# frozen_string_literal: true

require 'minitest/autorun'
require './day_5'


class Day5LineTest < MiniTest::Test
  def test_draw_vertical_line
    expected = [
      Day5::Coordinates.new(x: 0, y: 0),
      Day5::Coordinates.new(x: 0, y: 1),
      Day5::Coordinates.new(x: 0, y: 2),
      Day5::Coordinates.new(x: 0, y: 3),
    ]

    line = Day5::Line.new(from: Day5::Coordinates.new(x: 0, y: 0), to: Day5::Coordinates.new(x: 0, y: 3))
    assert_equal expected, line.draw
  end

  def test_draw_horizontal_line
    expected = [
      Day5::Coordinates.new(x: 0, y: 0),
      Day5::Coordinates.new(x: 1, y: 0),
      Day5::Coordinates.new(x: 2, y: 0),
      Day5::Coordinates.new(x: 3, y: 0),
    ]

    line = Day5::Line.new(from: Day5::Coordinates.new(x: 0, y: 0), to: Day5::Coordinates.new(x: 3, y: 0))
    assert_equal expected, line.draw
  end
end


class Day5Test < MiniTest::Test
  DATA = <<~TEXT
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_5_points_where_two_lines_overlap
    assert_equal 5, Day5.new(io: @data).compute_part_1!
  end

  # def test_returns_1924_score_for_the_last_board_to_win
  #   expected = 1924
  #   assert_equal expected, Day4.new(io: @data).compute_part_2!
  # end
end
