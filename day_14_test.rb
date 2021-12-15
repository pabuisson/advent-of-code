# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/focus'
require './day_14'

class Day14Test < MiniTest::Test
  DATA = <<~TEXT
    NNCB

    CH -> B
    HH -> N
    CB -> H
    NH -> C
    HB -> C
    HC -> B
    HN -> C
    NN -> C
    BH -> H
    NC -> B
    NB -> B
    BN -> B
    BB -> N
    BC -> B
    CC -> N
    CN -> C
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_1588_after_10_steps
    assert_equal 1_588, Day14.new(io: @data).compute_part_1!
  end

  def test_returns_2188189693529_after_40_steps
    assert_equal 2_188_189_693_529, Day14.new(io: @data).compute_part_2!
  end
end
