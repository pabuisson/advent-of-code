# frozen_string_literal: true

require './test_helper'
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

  def test_returns_correct_points_for_the_5_incomplete_lines
    expected = [288_957, 5566, 1_480_781, 995_444, 294]
    assert_equal expected, Day10.new(io: @data).part_2_scores
  end

  def test_returns_288957_final_score_for_the_5_incomplete_lines
    assert_equal 288_957, Day10.new(io: @data).compute_part_2!
  end
end
