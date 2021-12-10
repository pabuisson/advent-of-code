# frozen_string_literal: true

require 'minitest/autorun'
require './day_10'

class Day10Test < MiniTest::Test
  DATA = <<~TEXT
    [({(<(())[]>[[{[]{<()<>>
    [(()[<>])]({[<{<<[]>>(
    {([(<{}[<>[]}>{[]{[(<()>
    (((({<>}<{<{<>}{[]{[]{}
    [[<[([]))<([[{}[[()]]]
    [{[{({}]{}}([{[{{{}}([]
    {<[[]]>}<{[{[{[]{()[[[]
    [<(<(<(<{}))><([]([]()
    <{([([[(<>()){}]>(<<{{
    <{([{{}}[<[[[<>{}]]]>[]]
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_26397_points_for_the_5_corrupted_lines
    assert_equal 26_397, Day10.new(io: @data).compute_part_1!
  end

  def test_returns_1134_three_largest_basin_sizes_multiplied
  end
end
