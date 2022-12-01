# frozen_string_literal: true

require './test_helper'
require './day_4'

class Day4BoardTest < MiniTest::Test
  def test_winner_returns_true_for_board_with_marked_column
    b = Day4::Board.new
    b.add_line('1 2 3 4 5')
    b.add_line('6 7 8 9 10')
    b.mark!(1)
    b.mark!(6)
    assert b.winner?
  end

  def test_winner_returns_true_for_board_with_marked_row
    b = Day4::Board.new
    b.add_line('1 2 3')
    b.add_line('4 5 6')
    b.add_line('7 8 9')
    b.mark!(1)
    b.mark!(4)
    b.mark!(7)
    assert b.winner?
  end

  def test_winner_returns_false_if_no_marked_row_nor_column
    b = Day4::Board.new
    b.add_line('1 2 3')
    b.add_line('4 5 6')
    b.add_line('7 8 9')
    refute b.winner?
  end
end

class Day4Test < MiniTest::Test
  DATA = <<~TEXT
    7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

    22 13 17 11  0
     8  2 23  4 24
    21  9 14 16  7
     6 10  3 18  5
     1 12 20 15 19

     3 15  0  2 22
     9 18 13 17  5
    19  8  7 25 23
    20 11 10 24  4
    14 21 16 12  6

    14 21 17 24  4
    10 16 15  9 19
    18  8 23 26 20
    22 11 13  6  5
     2  0 12  3  7
  TEXT

  def setup
    @data = StringIO.new(DATA)
  end

  def test_returns_4512_score_for_the_first_board_to_win
    expected = 4_512
    assert_equal expected, Day4.new(io: @data).compute_part_1!
  end

  def test_returns_1924_score_for_the_last_board_to_win
    expected = 1924
    assert_equal expected, Day4.new(io: @data).compute_part_2!
  end
end
