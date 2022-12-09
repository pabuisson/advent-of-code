class Aoc2022::Day09
  def self.part_1(input, log = false)
    head_moves = format(input)
    rope = Rope.new(size: 2, log: log)
    tail_positions = [rope.tail_position] of Position

    head_moves
      .each do |head_move|
        former_tail_position = rope.tail_position
        rope.apply_move!(move: head_move)

        has_tail_moved = rope.tail_position != former_tail_position
        if has_tail_moved
          puts "[☄️] Tail moved to #{rope.tail_position}" if log
          tail_positions << rope.tail_position
        end
      end

    tail_positions.uniq.size
  end

  def self.part_2(input, log = false)
    head_moves = format(input)
    rope = Rope.new(size: 10, log: log)
    tail_positions = [rope.tail_position] of Position

    head_moves
      .each do |head_move|
        former_tail_position = rope.tail_position
        rope.apply_move!(move: head_move)

        has_tail_moved = rope.tail_position != former_tail_position
        if has_tail_moved
          puts "[☄️] Tail moved to #{rope.tail_position}" if log
          tail_positions << rope.tail_position
        end
      end

    tail_positions.uniq.size
  end

  def self.format(input)
    input
      .split("\n", remove_empty: true)
      .map do |line|
        direction, distance = line.split(" ")
        Move.new(direction: direction, distance: distance.to_i)
      end
      .flat_map { |move| move.decompose }
  end

  class Rope
    property head_position : Position
    private property rope
    private property log

    def initialize(size : Int32, log : Bool)
      @head_position = Position.new(x: 0, y: 0)
      @rope = Array(Position).new
      @log = log
      tail_size = size - 1
      tail_size.times { rope << @head_position }
    end

    def apply_move!(move : Move)
      puts "Applying move #{move}" if log

      new_head_position = move.apply(from: head_position)
      move_head_and_rest_of_rope!(to_new_head_position: new_head_position)
    end

    def move_head_and_rest_of_rope!(to_new_head_position : Position)
      move_head(to: to_new_head_position)
      move_rest_of_the_rope
      self
    end

    def tail_position
      rope.last
    end

    private def move_head(to : Position)
      puts "[🐱] Moving head to: #{to}" if log
      @head_position = to
    end

    private def move_rest_of_the_rope
      @rope =
        rope.each_with_object([] of Position) do |knot, previous_knots|
          previous_knot = previous_knots.empty? ? head_position : previous_knots.last
          previous_knots << move_knot(from: knot, towards: previous_knot)
        end
    end

    private def move_knot(from : Position, towards : Position)
      return from if from.adjacent?(to: towards)

      if from.x != towards.x || from.y != towards.y
        # move_diagonally
        if (from.x - towards.x).abs == 2
          new_x = (from.x + towards.x) // 2
          new_y = towards.y
          Position.new(x: new_x, y: new_y)
        else
          new_x = towards.x
          new_y = (from.y + towards.y) // 2
          Position.new(x: new_x, y: new_y)
        end
      else
        # move 1 in direction
        if from.x == towards.x
          Position.new(x: from.x, y: (from.y + towards.y) // 2)
        else
          Position.new(x: (from.x + towards.y) // 2, y: from.y)
        end
      end
    end
  end


  struct Move
    property :direction, :distance

    def initialize(@direction : String, @distance : Int32)
    end

    def decompose
      distance.times.map { Move.new(direction: direction, distance: 1) }.to_a
    end

    def apply(from : Position) : Position
      case direction
      when "R" then Position.new(x: from.x + distance, y: from.y)
      when "L" then Position.new(x: from.x - distance, y: from.y)
      when "U" then Position.new(x: from.x, y: from.y + distance)
      when "D" then Position.new(x: from.x, y: from.y - distance)
      else from
      end
    end

    def to_s
      "#{direction} #{distance}"
    end
  end

  struct Position
    property :x, :y

    def initialize(@x : Int32, @y : Int32)
    end

    def adjacent?(to : Position)
      (to.x - x).abs < 2 && (to.y - y).abs < 2
    end

    def to_s
      "(x: #{x}, y: #{y})"
    end
  end
end
