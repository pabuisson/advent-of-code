# frozen_string_literal: true

require './advent_day'
require 'ruby-prof'
require 'debug'


# My current approach is the naive one: it starts taking ages around blink 30. I managed to get a bit faster
# by caching the result corresponding to a value (thus reducing the int/strings manipulations) but it still
# takes a very long time and the memory used explodes (like ~1.5G at step 40!).
# The key to solve this is using a whole other algorithm than what is good enough for part 1.
class Day11 < AdventDay
  def part_1!(blinks_count: 25)
    stones = @data.first.split(' ').map(&:to_i)
    do_it(stones, blinks_count:)
  end

  # FIXME: that won't work :)
  def part_2!(blinks_count: 75)
    # stones = @data.first.split(' ').map(&:to_i)
    # do_it(stones, blinks_count:)
  end

  private

  def do_it(stones, blinks_count:)
    blinks =
      blinks_count.times.map do |i|
        stones = stones.flat_map { |stone| process_stone(stone) }
        puts "[#{i}] Result: #{stones.size} stones in the result"
        stones.size
      end

    { blinks:, result: blinks.last}
  end

  def process_stone(value_as_number)
    return 1 if value_as_number == 0

    value_as_string = value_as_number.to_s
    if value_as_string.size.even?
      middle_index = value_as_string.size / 2
      [value_as_string[0, middle_index].to_i,  value_as_string[middle_index..].to_i]
    else
      value_as_number * 2024
    end
  end

  class Memo
    def initialize
      @memo = Hash.new { |h, k| h[k] = {} }
    end

    def fetch(key, &block)
      cache = @memo[key.size]

      if cached_value = cache[key]
        cached_value
      else
        cache[key] = block.call
      end
    end
  end
end
