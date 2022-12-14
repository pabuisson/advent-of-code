class Aoc2022::Day14
  MAX_ROUND_TO_AVOID_INFINITE_LOOP = 50_000

  enum StopClause
    REACHED_ABYSS
    BLOCKING_SAND_ORIGIN
  end

  def self.part_1(input, log = false)
    cave = Cave.new(format(input: input))
    round = 0

    while round < MAX_ROUND_TO_AVOID_INFINITE_LOOP
      sand_final_position = cave.drop_sand(stop_clause: StopClause::REACHED_ABYSS)
      if sand_final_position
        cave.draw_sand(position: sand_final_position)
      else
        puts "[round #{round}] sand has reached the abyss, stop the loop" if log
        break
      end

      round += 1
    end

    puts cave.to_s if log
    round
  end

  def self.part_2(input, log = false)
    cave = Cave.new(format(input: input))
    round = 0

    while round < MAX_ROUND_TO_AVOID_INFINITE_LOOP
      sand_final_position = cave.drop_sand(stop_clause: StopClause::BLOCKING_SAND_ORIGIN)
      if sand_final_position
        cave.draw_sand(position: sand_final_position)
      else
        puts "[round #{round}] sand is now blocking the sand origin, stop the loop" if log
        break
      end

      round += 1
    end

    puts cave.to_s if log
    round + 1
  end

  class Cave
    private getter cave
    private getter sand_origin : Position
    private getter max_depth : Int32

    def initialize(lines_to_draw : Array({Position, Position}))
      @sand_origin = Position.new(x: 500, y: 0)
      @cave = Hash(Position, String).new
      @max_depth = 0
      lines_to_draw.each { |pair| draw_rock_lines(from: pair[0], to: pair[1]) }
    end

    def draw_sand(position : Position)
      draw_at(position: position, symbol: "o")
    end

    def drop_sand(stop_clause : StopClause) : Position?
      position = sand_origin
      stop_fn = stop_fn(stop_clause: stop_clause)

      while true
        position =
          if stop_fn && stop_fn.call(position)
            return nil
          elsif reached_max_depth?(position: position)
            # reached max depth, can't go any further down
            return position
          elsif empty_below?(position)
            Position.new(x: position.x, y: position.y + 1)
          elsif empty_below_left?(position)
            Position.new(x: position.x - 1, y: position.y + 1)
          elsif empty_below_right?(position)
            Position.new(x: position.x + 1, y: position.y + 1)
          else
            # the sand grain can't move any further, we return its current position and it stays there
            return position
          end
      end
    end

    private def stop_fn(stop_clause : StopClause)
      case stop_clause
      when StopClause::REACHED_ABYSS
        -> (p : Position) { reached_max_depth?(position: p) }
      when StopClause::BLOCKING_SAND_ORIGIN
        -> (p : Position) { blocking_sand_origin?(position: p) && !can_move?(position: p) }
      end
    end

    private def at(position : Position)
      cave[position] if cave.has_key?(position)
    end

    private def at(x : Int32, y : Int32)
      position = Position.new(x, y)
      at(position: position)
    end

    private def can_move?(position : Position)
      empty_below?(position) || empty_below_left?(position) || empty_below_right?(position)
    end

    private def empty_below?(position : Position)
      at(x: position.x, y: position.y + 1).nil?
    end

    private def empty_below_left?(position : Position)
      at(x: position.x - 1, y: position.y + 1).nil?
    end

    private def empty_below_right?(position : Position)
      at(x: position.x + 1, y: position.y + 1).nil?
    end

    private def reached_max_depth?(position : Position)
      position.y >= max_depth
    end

    private def blocking_sand_origin?(position : Position)
      position == sand_origin
    end

    private def draw_rock_lines(from : Position, to : Position)
      x_step = from.x < to.x ? 1 : -1
      y_step = from.y < to.y ? 1 : -1
      (from.x..to.x).step(by: x_step).each do |x|
        (from.y..to.y).step(by: y_step).each do |y|
          draw_at(x: x, y: y, symbol: "#")
        end
      end

      @max_depth = cave.keys.max_by { |p| p.y }.y + 1
    end

    private def draw_at(position : Position, symbol : String)
      cave[position] = symbol
    end

    private def draw_at(x : Int32, y : Int32, symbol : String)
      position = Position.new(x, y)
      cave[position] = symbol
    end

    def to_s
      min_x = cave.keys.min_by { |p| p.x }.x
      min_x = min_x - 1 if min_x > 0
      max_x = cave.keys.max_by { |p| p.x }.x

      (0..max_depth).each do |y|
        line = (min_x..max_x).map { |x| at(x: x, y: y) || "." }.join("")
        puts line
      end
    end
  end

  struct Position
    getter x, y

    def initialize(@x : Int32, @y : Int32)
    end

    def self.parse(comma_separated_values)
      x, y = comma_separated_values.split(",")
      self.new(x: x.to_i, y: y.to_i)
    end
  end

  def self.format(input : String)
    input.split("\n", remove_empty: true)
      .flat_map do |rock_line|
        rock_line
          .split(" -> ")
          .each_cons(2)
          .map { |couple| {Position.parse(couple[0]), Position.parse(couple[1])} }
      end
  end
end
