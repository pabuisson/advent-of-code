# frozen_string_literal: true

require './advent_day.rb'
require 'set'

class Day9 < AdventDay
  def compute_part_1!
    low_points = find_low_points(map: data)
    low_points.map { |point| point.height + 1 }.reduce(:+)
  end

  def compute_part_2!
    low_points = find_low_points(map: data)
    basins = low_points.map { |low_point| Basin.new(low_point: low_point) }

    basins.each do |basin|
      to_process = [basin.low_point]
      while to_process.any?
        point = to_process.pop

        higher_neighbors = point.find_higher_neighbors(map: data)
        to_process += higher_neighbors.reject { |neighbor| basin.has?(neighbor) }

        basin.add(point)
      end
    end

    basins.map(&:size).max(3).reduce(:*)
  end

  private

  def format_line(line:)
    line.chars.map(&:to_i)
  end

  def find_low_points(map: data)
    low_points =
      (0...map.size).flat_map do |row|
        map[row].map.with_index do |height, col|
          current = Point.new(row: row, col: col, height: height)
          current if current.low_point?(map: map)
        end
      end

    low_points.compact
  end

  Point = Struct.new(:row, :col, :height, keyword_init: true) do
    def low_point?(map:)
      neighbors = find_neighbors(map: map)
      neighbors.all? { |neighbor| neighbor.height > height }
    end

    def find_higher_neighbors(map:)
      find_neighbors(map: map).filter { |neighbor| neighbor.height > height && neighbor.height < 9 }
    end

    private

    def find_neighbors(map:)
      map_height = map.size
      map_width = map.first.size

      neighbors = []
      neighbors << Point.new(row: row - 1, col: col, height: map[row - 1][col]) if row.positive?
      neighbors << Point.new(row: row, col: col - 1, height: map[row][col - 1]) if col.positive?
      neighbors << Point.new(row: row + 1, col: col, height: map[row + 1][col]) if row < map_height - 1
      neighbors << Point.new(row: row, col: col + 1, height: map[row][col + 1]) if col < map_width - 1

      neighbors
    end
  end

  class Basin
    attr_reader :points, :low_point

    def initialize(low_point:)
      @points = Set.new([low_point])
      @low_point = low_point
    end

    def add(point)
      points << point
    end

    def has?(point)
      points.include?(point)
    end

    def size
      points.size
    end
  end
end
