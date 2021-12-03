# frozen_string_literal: true

class Day2
  attr_reader :data

  def initialize(data: load_data)
    @data = format_data(data)
  end

  def compute_part_1!
    position = Position.new
    data.each do |instruction|
      move = Move.new(instruction)
      position.move!(move)
    end

    puts "Final position: #{position.to_h}"
    position.x * position.depth
  end

  def compute_part_2!
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
