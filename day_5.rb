# frozen_string_literal: true

require './advent_day.rb'

class Day5 < AdventDay
  def compute_part_1!
    covered_points =
      data.flat_map do |line_input|
        raw_from, raw_to = line_input.split(' -> ')
        from = Coordinates.new(x: raw_from.split(',').first.to_i, y: raw_from.split(',').last.to_i)
        to = Coordinates.new(x: raw_to.split(',').first.to_i, y: raw_to.split(',').last.to_i)
        Line.new(from: from, to: to).draw
      end

    covered_points.tally.count { |_, number_of_lines| number_of_lines >= 2 }
  end

  def compute_part_2!
  end

  private

  class Line
    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def draw
      if vertical?
        draw_vertical
      elsif horizontal?
        draw_horizontal
      else
        []
      end
    end

    private

    attr_reader :from, :to

    def vertical?
      from.x == to.x
    end

    def draw_vertical
      fixed_x = from.x
      start, finish = [from.y, to.y].sort
      (start..finish).map { |y| Coordinates.new(x: fixed_x, y: y) }
    end

    def horizontal?
      from.y == to.y
    end

    def draw_horizontal
      fixed_y = from.y
      start, finish = [from.x, to.x].sort
      (start..finish).map { |x| Coordinates.new(x: x, y: fixed_y) }
    end
  end

  Coordinates = Struct.new(:x, :y, keyword_init: true)
end
