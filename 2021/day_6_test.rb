# frozen_string_literal: true

require './test_helper'
require './day_6'

class Day6Test < MiniTest::Test
  DATA = <<~TEXT
    3,4,3,1,2
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_5934_fishes_after_day_80
    assert_equal 5_934, Day6.new(io: @data).compute_part_1!
  end

  def test_returns_26_984_457_539_fishes_after_day_256
    assert_equal 26_984_457_539, Day6.new(io: @data).compute_part_2!
  end
end
