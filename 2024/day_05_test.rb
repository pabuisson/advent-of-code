# frozen_string_literal: true

require './test_helper'
require './day_05'

describe Day05 do
  before do
    @data = StringIO.new(<<~TEXT)
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    TEXT
  end

  it 'returns 143 for part 1' do
    assert_equal 143, Day05.new(io: @data).part_1!
  end

  it 'returns 123 for part 2' do
    assert_equal 123, Day05.new(io: @data).part_2!
  end
end
