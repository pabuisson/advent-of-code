class Aoc2022::Day10
  def self.part_1(input, log = false)
    instructions = format(input)
    reg_x_value = 1

    value_acc =
      instructions
        .flat_map do |instruction|
          Array.new(size: instruction.duration, value: reg_x_value).tap do
            reg_x_value += instruction.delta
          end
        end

    [20, 60, 100, 140, 180, 220].reduce(0) do |sum, cycle|
      sum += cycle * value_acc[cycle - 1]
    end
  end

  def self.part_2(input, log = false)
    instructions = format(input)
    reg_x_value = 1

    sprite_positions_by_cycle =
      instructions
        .flat_map do |instruction|
          sprite_positions = [reg_x_value - 1, reg_x_value, reg_x_value + 1]
          Array.new(size: instruction.duration, value: sprite_positions).tap do
            reg_x_value += instruction.delta
          end
        end

    rendering_matrix =
      (0..239).each_slice(40).to_a.map do |row_cycles|
        row_cycles.map do |cycle|
          horizontal_position = cycle % 40
          sprite_positions_by_cycle[cycle].includes?(horizontal_position) ? "#" : "."
        end.join("")
      end

    # puts "-----------------------"
    # rendering_matrix.each { |row| puts row }
    # puts "-----------------------"

    rendering_matrix
  end

  def self.format(input)
    input
      .split("\n", remove_empty: true)
      .map { |raw_instruction| Instruction.parse(raw_instruction) }
  end

  struct Instruction
    property :kind, :duration, :delta

    def self.parse(raw_instruction : String) : Instruction
      case raw_instruction
      when "noop" then self.new(kind: "noop", duration: 1, delta: 0)
      else
        kind, delta = raw_instruction.split(" ")
        self.new(kind: "addx", duration: 2, delta: delta.to_i)
      end
    end

    private def initialize(@kind : String, @duration : Int32, @delta : Int32)
    end
  end
end
