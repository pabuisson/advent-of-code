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
  end

  Plot = Data.define(:position, :letter)

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
