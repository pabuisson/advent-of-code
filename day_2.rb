# frozen_string_literal: true

class Day2
  attr_reader :data

  def initialize(data: load_data)
    @data = format_data(data)
  end

  def part_1_position
    position = Position.new
    data.each { |instruction| position.move!(Part1::Move.new(instruction)) }
    position.to_h
  end

  def compute_part_1!
    part_1_position[:x] * part_1_position[:depth]
  end

  def part_2_position
    sub = Part2::Submarine.new
    data.each { |instruction| sub.move!(instruction) }
    sub.position.to_h
  end

  def compute_part_2!
    part_2_position[:x] * part_2_position[:depth]
  end

  private

  def format_data(data)
    data.readlines.map(&:chomp)
  end

  def load_data
    File.open('./day_2.txt')
  end

  class Position
    attr_reader :x, :depth

    def initialize(x: 0, depth: 0)
      @x = x
      @depth = depth
    end

    def move!(move)
      self.x += move.x
      self.depth += move.depth
    end

    def to_h
      { x: x, depth: depth }
    end

    private

    attr_writer :x, :depth
  end

  module Part1
    class Move
      attr_reader :x, :depth

      def initialize(instruction)
        @x = 0
        @depth = 0
        parse(instruction)
      end

      private

      attr_writer :x, :depth

      def parse(instructions)
        direction, units = instructions.split(' ')
        case direction
        when 'forward'
          self.x = units.to_i
        when 'down'
          self.depth = units.to_i
        when 'up'
          self.depth = -units.to_i
        end
      end
    end
  end

  module Part2
    # Submarine objects holds its position, but also the aim value
    # Aim value is then passed as a param when we move forward to
    # compute how much the move forward will affect the depth, depending on the aim
    class Submarine
      attr_reader :aim, :position

      def initialize
        @position = Position.new(x: 0, depth: 0)
        @aim = 0
      end

      def move!(instruction)
        direction, units = instruction.split(' ')
        case direction
        when 'up'
          self.aim -= units.to_i
        when 'down'
          self.aim += units.to_i
        when 'forward'
          move = Part2::MoveForward.new(units: units, aim: aim)
          position.move!(move)
        end
      end

      private

      attr_writer :aim
    end

    # Moving forward affects the x value
    # But depending on the aim parameter, it can also affect the depth
    class MoveForward
      attr_reader :x, :depth

      def initialize(units:, aim:)
        @x = units.to_i
        @depth = compute_depth_delta(units: units.to_i, aim: aim)
      end

      private

      def compute_depth_delta(units:, aim:)
        units * aim
      end
    end
  end
end
