# frozen_string_literal: true

require './advent_day.rb'

class Day8 < AdventDay
  def compute_part_1!
    data.sum do |(_, output)|
      output.count { |output_digit| [2, 3, 4, 7].include?(output_digit.size) }
    end
  end

  def compute_part_2!
  end

  private

  def format_line(line:)
    line.split('|').map { |side| side.split(' ') }
  end
end
