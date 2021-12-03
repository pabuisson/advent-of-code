# frozen_string_literal: true

require 'minitest/autorun'
require './day_1'

class Day1Test < MiniTest::Test
  DATA = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263].freeze

  def test_returns_seven_for_the_given_data
    assert_equal 7, Day1.new(data: DATA).compute_part_1!
  end

  def test_returns_five_for_the_given_data
    Day1Part2.new(data: DATA).compute!
  end
end
