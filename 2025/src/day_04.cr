require "./base"

# ..@@.@@@@.
# @@@.@.@.@@
# @@@@@.@.@@
# @.@@@@..@.
# @@.@@@@.@@
# .@@@@@@@.@
# .@.@.@.@@@
# @.@@@.@@@@
# .@@@@@@@@.
# @.@.@@@.@.

class Day04 < Base
  struct Map
    property map : Array(Array(Char))

    def initialize(@map : Array(Array(Char)))
    end

    def at(position : Position)
      @map[position.row][position.col]
    end


    def height
      @map.size
    end

    def width
      @map.first.size
    end
  end

  struct Position
    property row : Int32
    property col : Int32

    def initialize(@row : Int32, @col : Int32)
    end

    def forkliftable?(map : Map)
      neighbours(at: self, map: map).count { |neighbour_pos| map.at(neighbour_pos) == '@' } < 4
    end

    private def neighbours(at : Position, map : Map)
      [
        Position.new(row: at.row - 1, col: at.col - 1),
        Position.new(row: at.row - 1, col: at.col),
        Position.new(row: at.row - 1, col: at.col + 1),
        Position.new(row: at.row, col: at.col - 1),
        Position.new(row: at.row, col: at.col + 1),
        Position.new(row: at.row + 1, col: at.col - 1),
        Position.new(row: at.row + 1, col: at.col),
        Position.new(row: at.row + 1, col: at.col + 1)
      ].select { |pos| pos.valid?(for_map: map) }
    end

    protected def valid?(for_map : Map)
      row >= 0 && row < for_map.height &&
        col >= 0 && col < for_map.width
    end
  end

  def self.part_1(input, must_log = false)
    map = Map.new(input.map(&.chars))

    input
      .map_with_index do |line, line_index|
        line.chars.map_with_index do |char, col_index|
          char == '@' && Position.new(row: line_index, col: col_index).forkliftable?(map)
        end
      end
      .flatten
      .count { |forkliftable| forkliftable == true }
  end

  def self.part_2(input, must_log = false)
  end
end
