# frozen_string_literal: true

require 'minitest/autorun'
require './day_2'

class Day2Test < MiniTest::Test
  DATA = <<~TEXT
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
  TEXT

  def test_move_forward_changes_x
    move = Day2::Move.new('forward 5')
    assert_equal 5, move.x
    assert_equal 0, move.depth
  end

  def test_move_down_increments_depth
    move = Day2::Move.new('down 5')
    assert_equal 0, move.x
    assert_equal 5, move.depth
  end

  def test_move_up_reduces_depth
    move = Day2::Move.new('up 5')
    assert_equal 0, move.x
    assert_equal(-5, move.depth)
  end

  def test_returns_15_x_10_for_the_given_data
    data = StringIO.new(DATA)
    expected = { h: 15, depth: 10 }
    assert_equal expected, Day2.new(data: data).compute_part_1!
  end

  # def test_returns_five_for_the_given_data
  # end
end
