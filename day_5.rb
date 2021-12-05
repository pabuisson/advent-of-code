# frozen_string_literal: true

require './advent_day.rb'

class Day5 < AdventDay
  def compute_part_1!
    covered_points =
      data.flat_map do |line_input|
        raw_from, raw_to = line_input.split(' -> ')
        from = Coordinates.from_string(raw_from)
        to = Coordinates.from_string(raw_to)
        Line.new(from: from, to: to).draw
      end

    covered_points.tally.count { |_, number_of_lines| number_of_lines >= 2 }
  end

  def compute_part_2!
    covered_points =
      data.flat_map do |line_input|
        raw_from, raw_to = line_input.split(' -> ')
        from = Coordinates.from_string(raw_from)
        to = Coordinates.from_string(raw_to)
        Line.new(from: from, to: to).draw(with_diagonals: true)
      end

    covered_points.tally.count { |_, number_of_lines| number_of_lines >= 2 }
  end

  private

  Coordinates = Struct.new(:x, :y, keyword_init: true) do
    def self.from_string(comma_separated_string)
      x, y = comma_separated_string.split(',').map(&:to_i)
      Coordinates.new(x: x, y: y)
    end
  end

  class Line
    def initialize(from:, to:)
      @from = from
      @to = to
    end

    def draw(with_diagonals: false)
      if vertical?
        draw_vertical
      elsif horizontal?
        draw_horizontal
      elsif with_diagonals == true
        draw_diagonal
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

    def draw_diagonal
      x_range = range(from: from.x, to: to.x)
      y_range = range(from: from.y, to: to.y)

      x_range.map.with_index do |x, index|
        Coordinates.new(x: x, y: y_range.to_a[index])
      end
    end

    def range(from:, to:)
      if from < to
        (from..to)
      else
        (from..to).step(-1)
      end
    end
  end
end
