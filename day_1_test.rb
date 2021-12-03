# frozen_string_literal: true

require 'minitest/autorun'
require './day_1'

class Day1Test < MiniTest::Test
  DATA = <<~TEXT
    199
    200
    208
    210
    200
    207
    240
    269
    260
    263
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_seven_for_the_given_data
    assert_equal 7, Day1.new(io: @data).compute_part_1!
  end

  def test_returns_five_for_the_given_data
    assert_equal 5, Day1.new(io: @data).compute_part_2!
  end
end
