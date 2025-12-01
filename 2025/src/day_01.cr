require "./base"

class Day01 < Base
  struct Move
    property direction : Char
    property number_of_clicks : Int32

    def initialize(move : String)
      @direction = move[0]
      @number_of_clicks = move.chomp[1..].to_i
    end

    def apply_to(starting_value : Int32, part : Part) : NamedTuple(crossed_zero: Int32, new_value: Int32)
      case part
      in Part::One
        new_value =
          if @direction == 'L'
            (starting_value - @number_of_clicks + 1000) % 100
          elsif @direction == 'R'
            (starting_value + @number_of_clicks) % 100
          else
            raise "Unexpected direction #{@direction}"
          end

        {crossed_zero: new_value == 0 ? 1 : 0, new_value: new_value}

      in Part::Two
        if @direction == 'L'
          new_value = (starting_value - @number_of_clicks)
          crossed_zero = (new_value.abs // 100)
          crossed_zero += 1 if starting_value > 0 && new_value <= 0
          {crossed_zero: crossed_zero, new_value: (new_value + 1000) % 100}
        elsif @direction == 'R'
          new_value = (starting_value + @number_of_clicks)
          crossed_zero = new_value // 100
          {crossed_zero: crossed_zero, new_value: new_value % 100}
        else
          raise "Unexpected direction #{@direction}"
        end
      end
    end
  end

  def self.part_1(input, must_log = false)
    input
    .map { |l| Move.new(l) }
      .reduce({current: 50, password: 0}) do |acc, move|
        move_result = move.apply_to(acc[:current].not_nil!, part: Part::One)
        new_value = move_result[:new_value].not_nil!
        puts "[#{move}] old: #{acc[:current]} // new: #{move_result}" if must_log

        {current: move_result[:new_value], password: acc[:password] + move_result[:crossed_zero].not_nil!}
      end
      .fetch(:password, nil)
  end

  def self.part_2(input, must_log = false)
    input
    .map { |l| Move.new(l) }
      .reduce({current: 50, password: 0}) do |acc, move|
        move_result = move.apply_to(acc[:current].not_nil!, part: Part::Two)
        puts "[#{move}] old: #{acc[:current]} // new: #{move_result}" if must_log

        {current: move_result[:new_value], password: acc[:password] + move_result[:crossed_zero].not_nil!}
      end
      .fetch(:password, nil)
  end
end

# ----------------------------------------------------

# # Only runs when this file is executed directly
# if PROGRAM_NAME.includes?("day_01")
#   input = File.read_lines("data/day_01.txt")
#   puts "Part 1: #{Day01.part_1(input, must_log: false)}"
#   puts "Part 2: #{Day01.part_2(input, must_log: false)}"
# end
