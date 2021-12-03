# frozen_string_literal: true

require 'minitest/autorun'
require './day_2'

class Day2MoveTest < MiniTest::Test
  def test_move_forward_changes_x
    move = Day2::Part1::Move.new('forward 5')
    assert_equal 5, move.x
    assert_equal 0, move.depth
  end

  def test_move_down_increments_depth
    move = Day2::Part1::Move.new('down 5')
    assert_equal 0, move.x
    assert_equal 5, move.depth
  end

  def test_move_up_reduces_depth
    move = Day2::Part1::Move.new('up 5')
    assert_equal 0, move.x
    assert_equal(-5, move.depth)
  end
end

class Day2Test < MiniTest::Test
  DATA = <<~TEXT
    forward 5
    down 5
    forward 8
    up 3
    down 8
    forward 2
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_15_x_10_for_the_given_data
    expected = { x: 15, depth: 10 }
    assert_equal expected, Day2.new(io: @data).part_1_position
  end

  def test_returns_150_for_the_given_data
    assert_equal 150, Day2.new(io: @data).compute_part_1!
  end

  def test_revised_version_returns_15_x_60_for_the_given_data
    expected = { x: 15, depth: 60 }
    assert_equal expected, Day2.new(io: @data).part_2_position
  end

  def test_revised_version_returns_900_for_the_given_data
    assert_equal 900, Day2.new(io: @data).compute_part_2!
  end
end
