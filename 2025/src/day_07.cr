require "./base"

class Day07 < Base
  struct TachyonManifold
    property starting_position : Position
    property splitter_positions : Array(Position)

    def initialize(@starting_position, @splitter_positions)
    end

    def splitters(at_line : Int32)
      splitter_positions.select { |p| p.line == at_line }
    end

    def max_line_index
      splitter_positions.max_of { |p| p.line }
    end

    def process_line(former_line_beams : Array(Position), line_index : Int32) : {beams: Array(Position), splits: Int32}
      splitters_at_line = splitters(at_line: line_index)

      initial_value = {beams: [] of Position, splits: 0}
      former_line_beams.reduce(initial_value) do |acc, beam_pos|
        splitter_at_same_col = splitters_at_line.any? { |p| p.col == beam_pos.col }
        if splitter_at_same_col
          {
            beams: (acc[:beams] + split_beam(beam_pos)).uniq,
            splits: acc[:splits] + 1
          }
        else
          {
            beams: acc[:beams] + extend_beam(beam_pos),
            splits: acc[:splits]
          }
        end
      end
    end

    private def split_beam(from : Position)
      [Position.new(from.line + 1, from.col - 1), Position.new(from.line + 1, from.col + 1)]
    end

    private def extend_beam(from : Position)
      [Position.new(from.line + 1, from.col)]
    end
  end

  struct Position
    property line : Int32
    property col : Int32

    def initialize(@line, @col)
    end

    def to_s(io : IO)
      io << "(#{@line}, #{@col})"
    end
  end

  def self.parse(input : Array(String)) : TachyonManifold
    starting_position = nil
    splitter_positions = [] of Position

    input.each_with_index do |line, line_index|
      line.chars.each_with_index do |char, col_index|
        if char == 'S'
          starting_position = Position.new(line_index, col_index)
        elsif char == '^'
          splitter_positions << Position.new(line_index, col_index)
        end
      end
    end

    TachyonManifold.new(
      starting_position: starting_position.not_nil!,
      splitter_positions: splitter_positions
    )
  end

  def self.part_1(input, must_log = false)
    mf = parse(input)
    result =
      (0..mf.max_line_index).reduce({beams: [mf.starting_position], splits: 0}) do |acc, line_index|
        line_result = mf.process_line(acc[:beams], line_index)

        {
          beams: line_result[:beams],
          splits: acc[:splits] + line_result[:splits]
        }
      end

    result[:splits]
  end

  def self.part_2(input, must_log = false)
    mf = parse(input)
    result =
      (0..mf.max_line_index).reduce([[mf.starting_position]]) do |acc, line_index|
        previous_line = acc.last
        line_result = mf.process_line(previous_line, line_index)
        acc << line_result[:beams]
      end


  end
end
