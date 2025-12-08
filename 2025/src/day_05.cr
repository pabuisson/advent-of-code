require "./base"

class Day05 < Base
  struct FreshRange
    property range : Range(Int64, Int64)

    def initialize(range : String)
      from, to = range.split("-").map(&.to_i64)
      @range = Range.new(from, to)
    end

    delegate includes?, to: @range
    delegate to_a, to: @range
  end

  def self.parse_input(input : Array(String)) : {ranges: Array(FreshRange), ingredients: Array(Int64)}
    input.reduce({ranges: [] of FreshRange, ingredients: [] of Int64}) do |acc, line|
      next acc if line.empty?

      if line.includes?("-")
        {ranges: acc[:ranges] << FreshRange.new(line), ingredients: acc[:ingredients]}
      else
        {ranges: acc[:ranges], ingredients: acc[:ingredients] << line.to_i64}
      end
    end
  end

  def self.part_1(input, must_log = false)
    data = parse_input(input)
    data[:ingredients].count do |ingredient|
      data[:ranges].any? { |range| range.includes?(ingredient) }
    end
  end

  # FIXME: does not work for real data. Stuck on the very first range.
  #        I must turn the collection of ranges in a collection of "disjoint" ranges.
  #        Then, I'll just have to sum the ranges size.
  # TODO: process the ranges so that they're all exclusive and I can just add their size
  def self.part_2(input, must_log = false)
    data = parse_input(input)
    puts "Number of FreshRanges: #{data[:ranges].size}"
    data[:ranges].flat_map { |range|
      puts "Range #{range}..."
      range.to_a
    }.uniq.size
  end
end
