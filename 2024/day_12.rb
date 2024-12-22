# frozen_string_literal: true

require './advent_day'
require 'debug'
require 'paint'

class Day12 < AdventDay
  def part_1!
    regions = Map.new(@data).regions

    { regions: regions, result: regions.sum(&:price) }
  end

  def part_2!
    regions = Map.new(@data).regions

    { regions: regions, result: regions.sum(&:price) }
  end

  private

  Position = Data.define(:line, :col) do
    def to_s = "(#{line},#{col})"
    def top_left_corner = Position[line, col]
    def top_right_corner = Position[line, col + 1]
    def bottom_left_corner = Position[line + 1, col]
    def bottom_right_corner = Position[line + 1, col + 1]
  end

  Plot = Data.define(:position, :letter)

  Side = Data.define(:dir, :x, :y) do
    def to_s = "#{symbol} from #{x} to #{y}"
    def symbol = dir == :h ? '—' : '|'
  end

  Region = Data.define(:positions, :letter) do
    def price = area * perimeter
    def area = positions.uniq.size
    def perimeter
      positions.uniq.reduce(0) do |acc, p|
        acc += [
          Position[p.line, p.col - 1],
          Position[p.line, p.col + 1],
          Position[p.line - 1, p.col],
          Position[p.line + 1, p.col]
        ].count { |p| !positions.include?(p) }
      end
    end

    # FIXME: this is what I need for part 2.
    #        my initial idea is to turn all positions into a segment, depending on the "free side" of the position,
    #        if any.
    #        then, 2nd step is to find the successive sides that have the same direction and a common beginning or end
    #        BUT be careful of the cases where 2 squares "join" each other diagonally, like explained in today's description
    #        or added in the tests
    def sides
      all_free_unit_sides =
        positions
          .uniq
          .flat_map do |p|
            left = Position[p.line, p.col - 1]
            right = Position[p.line, p.col + 1]
            top = Position[p.line - 1, p.col]
            down = Position[p.line + 1, p.col]

            free_sides = []
            free_sides << Side[:v, p.top_left_corner, p.bottom_left_corner] if !positions.include?(left)
            free_sides << Side[:v, p.top_right_corner, p.bottom_right_corner] if !positions.include?(right)
            free_sides << Side[:h, p.top_left_corner, p.top_right_corner] if !positions.include?(top)
            free_sides << Side[:h, p.bottom_left_corner, p.bottom_right_corner] if !positions.include?(down)

            free_sides
          end

      processed_sides = []
      # TODO: don't forget to "join" with the first side initial item?
      while all_free_unit_sides.any?
      end
    end
  end

  class Map
    def initialize(data)
      @plots = data.map.with_index do |line, line_index|
        line.chars.map.with_index do |c, col_index|
          Plot[Position[line_index, col_index], c]
        end
      end
    end

    def regions
      to_process = @plots.dup.flatten.map(&:position)

      regions = []
      while to_process.any?
        from = to_process.first
        letter = at(from).letter

        regions << Region.new(
          positions: contiguous_identical_positions(@plots, from),
          letter: letter
        )

        to_process -= regions.last.positions
      end

      regions
    end

    def contiguous_identical_positions(plots, from_position, region_positions = [])
      region_letter = at(from_position).letter

      valid_neighbours(from_position)
        .select { |p| at(p).letter == region_letter }
        .reject { |p| region_positions.include?(p) }
        .flat_map do |p|
          # Appends the result to region positions immediately. If I don't, then I could end up
          # in a loop, going though identical nodes via several neighours and looping endlessly
          region_positions += contiguous_identical_positions(plots, p, region_positions + [from_position])
        end.uniq + [from_position]
    end


    def draw(region = nil)
      max_letter = @plots.flatten.map(&:letter).max

      @plots.each_with_index do |line, line_index|
        formatted_line =
          line.map do |plot, col_index|
            if region&.positions&.include?(plot.position)
              "❇️"
            else
              letter_to_color(plot.letter, max_letter)
            end
          end

        puts formatted_line.join('|')
      end
      puts ""
    end

    private

    def at(position) = @plots[position.line][position.col]

    def valid_neighbours(position)
      [
          Position[position.line, position.col - 1],
          Position[position.line, position.col + 1],
          Position[position.line - 1, position.col],
          Position[position.line + 1, position.col]
      ].select { |p| valid?(p) }
    end

    def valid?(position)
      position.col >= 0 && position.line >= 0 && position.line < @plots.size && position.col < @plots.first.size
    end

    def letter_code(letter) = letter.upcase.codepoints.first % 65

    def letter_to_color(letter, max_c = 'Z')
      char = letter.upcase.codepoints.first % 65
      max_hexa = 256 * 256 * 256
      char_on_range = letter_code(letter) * max_hexa / letter_code(max_c)

      x = "#%06x" % char_on_range

      Paint['▓▓', x]
    end
  end
end
