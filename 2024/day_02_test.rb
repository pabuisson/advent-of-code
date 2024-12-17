# frozen_string_literal: true

require './test_helper'
require './day_02'


describe Day02 do
  before do
    @data = StringIO.new(<<~TEXT)
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    TEXT
  end

  it 'returns 2 safe reports for part 1' do
    assert_equal 2, Day02.new(io: @data).part_1!
  end

  describe 'part 2' do
    it 'returns 4 safe reports for part 2 with problem dampener' do
      assert_equal 4, Day02.new(io: @data).part_2!
    end

    # Some specific cases

    it 'return 0 for a report where more than two levels have same value' do
      data = StringIO.new("6 8 9 9 10 10")
      assert_equal 0, Day02.new(io: data).part_2!

      data = StringIO.new("6 8 9 9 9 10")
      assert_equal 0, Day02.new(io: data).part_2!
    end

    it 'return 1 for a report where last level is invalid' do
      data = StringIO.new([6, 8, 9, 11, 10].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!

      data = StringIO.new([6, 8, 9, 11, 11].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!

      data = StringIO.new([6, 8, 9, 11, 18].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!
    end

    it 'return 1 for a report where 2nd-to-last level is invalid' do
      data = StringIO.new([6, 8, 9, 11, 10, 12].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!

      data = StringIO.new([6, 8, 9, 11, 11, 12].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!

      data = StringIO.new([6, 8, 9, 11, 18, 12].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!
    end

    it 'return 0 for a report where last two levels are invalid' do
      data = StringIO.new([5, 8, 11, 10, 9].join(' '))
      assert_equal 0, Day02.new(io: data).part_2!

      data = StringIO.new([5, 8, 11, 11, 11].join(' '))
      assert_equal 0, Day02.new(io: data).part_2!

      data = StringIO.new([5, 8, 11, 20, 30].join(' '))
      assert_equal 0, Day02.new(io: data).part_2!
    end

    it 'returns 1 for a valid report, both increasing and decreasing' do
      data = StringIO.new([5, 8, 11, 14, 16].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!

      data = StringIO.new([12, 10, 9, 6, 4].join(' '))
      assert_equal 1, Day02.new(io: data).part_2!
    end

    # NOTE: from my input, I was not identifying this one correctly as a success
    describe 'missed cases from the inputs' do
      it 'returns 1 for a report where one level is invalid' do
        data = StringIO.new([18, 21, 23, 22, 23, 26, 28].join(' '))
        assert_equal 1, Day02.new(io: data).part_2!
      end

      it 'returns 1 for a report where the first level only is invalid' do
        data = StringIO.new([21, 24, 23, 21, 20, 19, 18].join(' '))
        assert_equal 1, Day02.new(io: data).part_2!

        data = StringIO.new([45, 52, 54, 56, 58, 60].join(' '))
        assert_equal 1, Day02.new(io: data).part_2!
      end
    end
  end
end
