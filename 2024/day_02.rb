# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day02 < AdventDay
  def part_1!
    @data.count { |report_levels| Report.new(report_levels).safe? }
  end

  def part_2!
    @data.count { |report_levels| ReportWithDampener.new(report_levels).safe? }
  end

  class Report
    attr_reader :levels

    def initialize(levels_string)
      @levels = levels_string.split(' ').map(&:strip).map(&:to_i)
    end

    def safe?
      (increasing?(levels) || decreasing?(levels)) && in_range?(levels)
    end

    private

    def increasing?(levels)
      self.levels == levels.sort
    end

    def decreasing?(levels)
      self.levels == levels.sort.reverse
    end

    def in_range?(levels)
      levels.each_cons(2).all? { |a, b| (a - b).abs.between?(1, 3) }
    end
  end

  class ReportWithDampener
    attr_reader :levels

    def initialize(levels_string)
      @levels = levels_string.split(' ').map(&:strip).map(&:to_i)
    end

    def safe?
      (increasing?(levels) && in_range?(levels, 1, 3)) || 
       (decreasing?(levels) && in_range?(levels, -3, -1))
    end

    private 

    def increasing?(levels)
      exceptions_met = 0
      levels.each_cons(2).each { |a, b| exceptions_met += 1 if a > b }
      (exceptions_met == 0 || exceptions_met == 1)
    end

    def decreasing?(levels)
      exceptions_met = 0
      levels.each_cons(2).each { |a, b| exceptions_met += 1 if a < b }
      (exceptions_met == 0 || exceptions_met == 1)
    end

    def in_range?(levels, min, max)
      levels.each_cons(3).each do |a, b, c|
        next if (a - b).between?(min, max)

        return false if !(a - c).between?(min, max)
      end

      true
    end
  end
end
