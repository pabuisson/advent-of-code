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

    EMPTY_CHAR = '.'

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

    def empty!(position : Position)
      @map[position.row][position.col] = EMPTY_CHAR
    end

    def all_positions
      positions =
        @map.map_with_index do |line, line_index|
          line.map_with_index do |char, col_index|
            Position.new(row: line_index, col: col_index)
          end
        end
        .flatten
        .compact
    end

    def all_positions(&block)
      all_positions.select { |p| yield(p) }
    end
  end

  struct Position
    property row : Int32
    property col : Int32

    FORKLIFTABLE_CHAR = '@'

    def initialize(@row : Int32, @col : Int32)
    end

    def forkliftable?(map : Map)
      map.at(self) == FORKLIFTABLE_CHAR &&
        neighbours(at: self, map: map).count { |neighbour_pos| map.at(neighbour_pos) == FORKLIFTABLE_CHAR } < 4
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
    map.all_positions { |p| p.forkliftable?(map) }.size
  end

  def self.part_2(input, must_log = false)
    map = Map.new(input.map(&.chars))
    removed_at_step = [] of Int32

    forkliftable_positions = map.all_positions { |p| p.forkliftable?(map) }
    while forkliftable_positions.any?
      removed_at_step << forkliftable_positions.size
      forkliftable_positions.each { |fp| map.empty!(fp) }
      forkliftable_positions = map.all_positions { |p| p.forkliftable?(map) }
    end

    pp removed_at_step if must_log

    removed_at_step.sum
  end
end
