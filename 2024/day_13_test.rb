# frozen_string_literal: true

require './test_helper'
require './day_13'

describe Day13 do
  before do
    @data = StringIO.new(<<~TEXT)
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
    TEXT
  end

  describe 'part 1' do
    focus
    it 'return 280 for 1st claw machine' do
      data = StringIO.new(<<~TEXT)
        Button A: X+94, Y+34
        Button B: X+22, Y+67
        Prize: X=8400, Y=5400
      TEXT

      puts "1st claw"
      assert_equal 280, Day13.new(io: data).part_1!
    end

    focus
    it 'return 200 for 3rd claw machine' do
      data = StringIO.new(<<~TEXT)
        Button A: X+17, Y+86
        Button B: X+84, Y+37
        Prize: X=7870, Y=6450
      TEXT

      puts "3rd claw"
      assert_equal 200, Day13.new(io: data).part_1!
    end

    focus
    it 'return 0 for 2nd and 4th claw machine' do
      data = StringIO.new(<<~TEXT)
        Button A: X+26, Y+66
        Button B: X+67, Y+21
        Prize: X=12748, Y=12176

        Button A: X+69, Y+23
        Button B: X+27, Y+71
        Prize: X=18641, Y=10279
      TEXT

      assert_equal 0, Day13.new(io: data).part_1!
    end

    focus
    it 'returns 480 for part 1' do
      assert_equal 480, Day13.new(io: @data).part_1!
    end
  end

  # describe 'part 2' do
  #   focus
  #   it 'return 0 for 1st and 3rd claw machine' do
  #     data = StringIO.new(<<~TEXT)
  #     Button A: X+94, Y+34
  #     Button B: X+22, Y+67
  #     Prize: X=8400, Y=5400
  #
  #     Button A: X+17, Y+86
  #     Button B: X+84, Y+37
  #     Prize: X=7870, Y=6450
  #     TEXT
  #
  #     assert_equal 0, Day13.new(io: data).part_2!
  #   end
  # end
end
