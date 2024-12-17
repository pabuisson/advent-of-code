# frozen_string_literal: true

require './advent_day'
require 'debug'

# Not sure why I found this one so, so difficult. It took me a long time to correctly understand the 2nd part,
# and to finally reach a working solution. And I only managed to identify my algorithm problems by checking
# the incorrect responses with a working solution, I'm not sure I would have found out without this 🤷
class Day02 < AdventDay
  def part_1! = @data.count { |levels| Report.new(levels).safe? }
  def part_2! = @data.count { |levels| ReportWithDampener.new(levels).safe? }

  class Report
    def initialize(levels_string)
      @levels = levels_string.split(' ').map(&:strip).map(&:to_i)
    end

    def safe? = in_range?(@levels, (1..3)) || in_range?(@levels, (-3..-1))
    def in_range?(levels, range) = levels.each_cons(2).all? { |a, b| range.include?(a - b) }
  end

  class ReportWithDampener
    def initialize(levels_string)
      @levels = levels_string.split(' ').map(&:strip).map(&:to_i)
    end

    def safe? = in_range?(@levels, (1..3)) || in_range?(@levels, (-3..-1))

    def in_range?(levels, range, without_index: nil)
      actual_levels = without_index.nil? ? levels : levels[...without_index] + levels[(without_index + 1)..]

      index = 1
      while index < actual_levels.size
        previous = actual_levels[index - 1]
        current = actual_levels[index]

        if range.include?(current - previous)
          index += 1
        elsif without_index.nil?
          # The dampening process
          return in_range?(actual_levels, range, without_index: index) || in_range?(actual_levels, range, without_index: index - 1)
        else
          return false
        end
      end

      true
    end
  end
end
