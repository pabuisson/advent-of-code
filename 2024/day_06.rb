# frozen_string_literal: true

require './advent_day'
require 'debug'
require 'benchmark'

# Part 2 took me way too much time. I eneded up with a bruteforce algorithm, my initial "smarter" solution
# was wrong, somehow.
class Day06 < AdventDay
  def part_1! = Map.new(data).unique_guard_positions.size
  def part_2! = Map.new(data).look_for_loops.uniq.size

  # One coordinate of the map
  Position = Data.define(:line, :col) do
    def to_s = "(#{line},#{col})"
  end

  # One occurrence where the guard reached a position from a certain direction. We need the direction for part 2,
  # to identify loops (a guard can step multiple times on one single position without it being a loop)
  GuardStep = Data.define(:position, :incoming_direction) do
    def to_s = "#{position} #{incoming_direction}"
  end

  # Holds all the logic related to the map and the way we move through the map
  class Map
    NATURAL_OBSTACLE = '#'
    ADDED_OBSTACLE = 'O'
    DIRECTIONS = %w[^ > v <].freeze

    def initialize(data, custom_obstacle_at: nil)
      @original_data = data
      @map = data.map(&:chars)

      guard_position = find_guard(@map)
      @current_guard_direction = @map[guard_position.line][guard_position.col]
      @guard_positions = [GuardStep[guard_position, @current_guard_direction]]

      if custom_obstacle_at && custom_obstacle_at != guard_position
        @map[custom_obstacle_at.line][custom_obstacle_at.col] = ADDED_OBSTACLE
      end
    end

    def unique_guard_positions
      run_until_loop_or_end
      guard_positions.uniq(&:position)
    end

    def look_for_loops
      loops_if_obstacle_at = []

      @map.each_with_index do |line, line_index|
        line.each_with_index do |char, col_index|
          next if char == NATURAL_OBSTACLE

          position = Position[line_index, col_index]
          hypothetical_map = Map.new(@original_data, custom_obstacle_at: position)

          case hypothetical_map.run_until_loop_or_end(exit_on_loop: true)
          in [:looping, *]
            puts "Found one new loop for #{position}! » #{loops_if_obstacle_at.size + 1} loops found so far"
            loops_if_obstacle_at << position
          else
            # noop
          end
        end
      end

      loops_if_obstacle_at.uniq
    end

    protected

    def run_until_loop_or_end(exit_on_loop: false)
      current_position = find_guard(@map)

      loop do
        case next_position(current_position, @current_guard_direction)
        in [:ok, Position => p]
          if blocked?(p)
            rotate!
            return [:looping, nil] if exit_on_loop == true && looping?
          else
            guard_positions << GuardStep[p, @current_guard_direction]
            current_position = p
          end
        in [:out_of_bonds, *] then break
        end
      end

      [:no_loop, nil]
    end

    private

    attr_reader :guard_positions

    def find_guard(map)
      map.each_with_index do |line, line_index|
        line.each_with_index do |value, col_index|
          return Position[line_index, col_index] if DIRECTIONS.include?(value)
        end
      end
    end

    def next_position(from_position, direction)
      new_position =
        case direction
        when '^' then Position.new(from_position.line - 1, from_position.col)
        when '>' then Position.new(from_position.line, from_position.col + 1)
        when 'v' then Position.new(from_position.line + 1, from_position.col)
        when '<' then Position.new(from_position.line, from_position.col - 1)
        end

      out_of_bonds?(new_position) ? [:out_of_bonds, new_position] : [:ok, new_position]
    end

    def blocked?(p) = [NATURAL_OBSTACLE, ADDED_OBSTACLE].include?(@map[p.line][p.col])
    def out_of_bonds?(p) = p.line.negative? || p.col.negative? || p.line >= @map.size || p.col >= @map.first.size
    def looping? = guard_positions.tally.any? { |_step, count| count > 1 }

    def rotate!
      new_direction_index = (DIRECTIONS.find_index { _1 == @current_guard_direction } + 1) % 4
      @current_guard_direction = DIRECTIONS[new_direction_index]
    end
  end
end
