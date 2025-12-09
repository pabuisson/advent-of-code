require "./base"

# BE CAREFUL NOT TO REMOVE TRAILING SPACES FROM THE EXAMPLE INPUT
# The "real" input has no trailing spaces so no problems to be expected

class Day06 < Base
  struct Operation
    property operands : Array(Int64)
    property operation : String | Nil

    def initialize
      @operands = [] of Int64
      @operation = nil
    end

    def initialize(operands : Array(String), @operation : String)
      @operands = operands.map(&.to_i64)
    end

    def compute
      case @operation
      when "*"
        @operands.reduce(1.to_i64) { |acc, i| acc * i }
      when "+"
        @operands.reduce(0.to_i64) { |acc, i| acc + i }
      else
        raise "Unknown operation #{@operation}"
      end
    end
  end

  # 123 328  51 64
  #  45 64  387 23
  #   6 98  215 314
  # *   +   *   +
  def self.parse(input : Array(String), part : Part) : Array(Operation)
    case part
      when Part::One
        operands_lines = input[0..-2].map { |line| line.split(/\s+/).reject(&.empty?) }
        operators = input.last.split(/\s+/).reject(&.empty?)
        operators
          .size
          .times
          .map { |op_index| Operation.new(operands_lines.map { |line| line[op_index].to_s }, operators[op_index].to_s) }
          .to_a
      when Part::Two
        operands_lines = input[0..-2].map { |line| line.reverse }
        operators = input.last.reverse
        input_width = input.max_by(&.size)

        result =
          input_width.size.times.reduce({operations: [] of Operation, current: Operation.new()}) do |acc, col|
            if operators[col] == ' ' && operands_lines.all? { |line| line[col] == ' ' }
              {operations: acc[:operations] << acc[:current], current: Operation.new()}
            else
              column_operand = operands_lines.map { |line| line[col].to_s }.join("").strip()
              acc[:current].operands << column_operand.to_i64 unless column_operand.blank?
              acc[:current].operation = operators[col].to_s unless operators[col].to_s.blank?
              # We can simply return because we **mutated** acc[:current]
              # This is bad but it works and will be good enough :)
              acc
            end
          end

        result[:operations] << result[:current]
    end.not_nil!
  end

  def self.part_1(input, must_log = false)
    self.parse(input, part: Part::One)
      .tap { |all| pp all if must_log }
      .sum { |op| op.compute }
  end

  def self.part_2(input, must_log = false)
    self.parse(input, part: Part::Two)
      .tap { |all| pp all if must_log }
      .sum { |op| op.compute }
  end
end
