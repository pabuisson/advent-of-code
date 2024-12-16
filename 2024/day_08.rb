# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day08 < AdventDay
  def part_1!
    Map.new(@data).all_antinode_locations.size
  end

  def part_2!
    Map.new(@data).all_antinode_locations(repeated: true).size
  end


  Position = Data.define(:line, :col) do
    def to_s = "(#{line},#{col})"
  end

  Antenna = Data.define(:code, :position) do
    def to_s = "#{code} at #{position}"
  end

  class Map
    attr_reader :antennas

    def initialize(data)
      @map = data.map(&:chars)
      @antennas = @map.flat_map.with_index do |line, line_index|
        line.filter_map.with_index do |value, col_index|
          next if value == '.'

          p = Position[line_index, col_index]
          Antenna[value, p]
        end
      end
    end

    def all_antinode_locations(repeated: false)
      antennas
        .group_by(&:code)
        .flat_map do |_code, positions|
          positions
            .map(&:position)
            .permutation(2)
            .flat_map { |permutation| antinode_locations_for(permutation.first, permutation.last, repeated:) }
            .compact
        end.uniq
    end

    def antinode_locations_for(p1, p2, repeated: false)
      delta_line = (p1.line - p2.line).abs
      delta_col = (p1.col - p2.col).abs

      left_point = [p1, p2].min_by(&:col)
      right_point = ([p1, p2] - [left_point]).first

      is_left_point_above = left_point.line < right_point.line
      range = repeated ? (1..10000) : (1..1)

      # Pretty nice to use a lazy enumator + take_while, which, in this case,
      # is also really easy to understand because it maps exactly with what I'm doing
      candidates_left =
        range.lazy.map do |i|
          new_candidate_left = Position.new(
            col: left_point.col - i * delta_col,
            line: is_left_point_above ? left_point.line - i * delta_line : left_point.line + i * delta_line
          )
        end.take_while { valid?(_1) }.to_a

      # Pretty nice to use a lazy enumator + take_while, which, in this case,
      # is also really easy to understand because it maps exactly with what I'm doing
      candidates_right =
        range.lazy.map do |i|
          new_candidate_right = Position.new(
            col: right_point.col + i * delta_col,
            line: is_left_point_above ? right_point.line + i * delta_line : right_point.line - i * delta_line
          )
        end.take_while { valid?(_1) }.to_a

      (candidates_left || []) + (candidates_right || []) + (repeated ? [p1, p2] : [])
    end

    def draw(repeated: false)
      antinodes = all_antinode_locations(repeated:)

      @map.each_with_index do |line, line_index|
        puts (line.map.with_index do |char, col_index|
          a = @antennas.find { _1.position == Position[line_index, col_index] }
          an = antinodes.find { _1 == Position[line_index, col_index] }
          if a
            a.code
          elsif an
            '#'
          else
            '.'
          end
        end).join('')
      end
    end

    private

    attr_reader :map

    def valid?(position)
      position.line.between?(0, map.size - 1) && position.col.between?(0, map.first.size - 1)
    end
  end
end
