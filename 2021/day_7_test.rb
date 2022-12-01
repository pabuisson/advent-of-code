# frozen_string_literal: true

require './test_helper'
require './day_7'

class Day7Test < MiniTest::Test
  DATA = <<~TEXT
    16,1,2,0,4,2,7,1,2,14
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_37_fuel_for_least_consuming_move
    assert_equal 37, Day7.new(io: @data).compute_part_1!
  end

  def test_returns_168_fuel_for_least_consuming_move_in_part_2
    assert_equal 168, Day7.new(io: @data).compute_part_2!
  end

  def test_fuel_consumption_returns_6_from_0_to_3
    assert_equal 6, Day7.new(io: @data).send(:fuel_consumption_part_2, from: 0, to: 3)
  end

  def test_fuel_consumption_returns_6_from_1_to_4
    assert_equal 6, Day7.new(io: @data).send(:fuel_consumption_part_2, from: 1, to: 4)
  end
end
