# frozen_string_literal: true

require './advent_day.rb'

class Day9 < AdventDay
  def compute_part_1!
    low_points = []

    (0...data.size).each do |row|
      data[row].each_with_index do |height, col|
        adjacents = find_adjacent(row: row, col: col, map: data)
        low_points << height if low_point?(current: height, adjacents: adjacents)
      end
    end

    pp low_points

    low_points.map { |height| height + 1 }.reduce(:+)
  end

  def compute_part_2!
  end

  private

  def format_line(line:)
    line.chars.map(&:to_i)
  end

  def find_adjacent(row:, col:, map:)
    map_height = map.size
    map_width = map.first.size

    adjacents = []
    adjacents << map[row-1][col] if row.positive?
    adjacents << map[row][col-1] if col.positive?
    adjacents << map[row+1][col] if row < map_height - 1
    adjacents << map[row][col+1] if col < map_width - 1

    adjacents
  end

  def low_point?(current:, adjacents:)
    adjacents.all? { |adjacent| adjacent > current }
  end
end
