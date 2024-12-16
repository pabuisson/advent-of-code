# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day03 < AdventDay
  def part_1!
    @data
      .first
      .scan(/mul\((\d{1,3}),(\d{1,3})\)/)
      .map { _1.to_i * _2.to_i }
      .sum
  end

  def part_2!
    @data
      .join('')
      .split('do()')
      .map { _1.split("don't()").first }
      .flat_map { _1.scan(/mul\((\d{1,3}),(\d{1,3})\)/) }
      .map { _1.to_i * _2.to_i }
      .sum
  end
end
