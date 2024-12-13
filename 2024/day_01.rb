# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day01 < AdventDay
  LEFT = 0
  RIGHT = 1

  def part_1!
    left, right = 
      @data.reduce([[], []]) do |acc, current|
        l, r = current.split(' ').map(&:strip)
        [
          (acc[LEFT] + [l.to_i]).sort, 
          (acc[RIGHT] + [r.to_i]).sort
        ]
      end

    left.map.with_index { |_, index| (left[index] - right[index]).abs }.sum
  end

  def part_2!
    left, right = 
      @data.reduce([[], []]) do |acc, current|
        l, r = current.split(' ').map(&:strip)
        [
          (acc[LEFT] + [l.to_i]), (acc[RIGHT] + [r.to_i])
        ]
      end

    left.map { |l| l * right.count(l) }.sum
  end
end
