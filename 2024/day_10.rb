# frozen_string_literal: true

require './advent_day'
require 'debug'


# Pretty happy with this one, it was quite fun and my code almost immediately worked for part 2 :)
class Day10 < AdventDay
  def part_1!
    topo_map = TopoMap.new(@data)
    trailheads = topo_map.trailhead_positions
    valid_paths_count = trailheads.sum { topo_map.number_of_paths(_1).uniq.size }

    { trailheads_count: trailheads.size, result: valid_paths_count }
  end

  def part_2!
    topo_map = TopoMap.new(@data)
    trailheads = topo_map.trailhead_positions
    valid_paths_count = trailheads.sum { topo_map.number_of_paths(_1).size }

    { trailheads_count: trailheads.size, result: valid_paths_count }
  end

  class TopoMap
    Position = Data.define(:line, :col)

    def initialize(data)
      @topo = data.map { |line| line.chars.map(&:to_i) }
    end

    def trailhead_positions
      @topo.flat_map.with_index do |line, line_index|
        line.filter_map.with_index { |height, col_index| Position[line_index, col_index] if height.zero? }
      end
    end

    def at(position) = @topo[position.line][position.col]
    def valid?(position) = position.col >= 0 && position.line >= 0 && position.line < @topo.size && position.col < @topo.first.size

    def number_of_paths(position, previous_height = -1)
      current_height = at(position)

      return nil if current_height - previous_height != 1
      return position if at(position) == 9

      [
        Position[position.line - 1, position.col],
        Position[position.line + 1, position.col],
        Position[position.line, position.col + 1],
        Position[position.line, position.col - 1]
      ].select { |p| valid?(p) }.filter_map { |p| number_of_paths(p, current_height) }.flatten
    end
  end
end
