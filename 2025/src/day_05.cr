require "./base"

class Day05 < Base
  struct FreshRange
    property range : Range(Int128, Int128)

    def initialize(range : String)
      from, to = range.split("-").map(&.to_i128)
      @range = Range.new(from, to)
    end

    def initialize(from : Int128, to : Int128)
      @range = Range.new(from, to)
    end

    delegate :includes?, to: @range
    delegate :begin, to: @range
    delegate :end, to: @range
    delegate :size, to: @range

    def overlaps_or_consecutive?(other : FreshRange)
      consecutive?(other) || overlaps?(other)
    end

    private def consecutive?(other : FreshRange)
      (other.begin == self.end && other.end >= self.end) ||
        (other.end == self.begin && other.begin <= self.begin)
    end

    private def overlaps?(other : FreshRange)
      (other.begin < self.begin && other.end > self.begin) ||
        (other.begin < self.end && other.end > self.end) ||
        (other.begin >= self.begin && other.end <= self.end)
    end

    # Extends self with the new range.
    # self and other must overlap or be immediately consecutive, otherwise will raise an exception
    def merge(other : FreshRange) : FreshRange
      raise "#{self} and #{other} are disjoint, can't merge them" unless overlaps_or_consecutive?(other)
      FreshRange.new([self.begin, other.begin].min, [self.end, other.end].max)
    end

    # Need to override this: Range.size raises an OverflowError
    # +1 because it must count the number of items with both ends included
    def size
      (@range.end - @range.begin) + 1
    end

    def to_s(io : IO)
      io << "FreshRange(#{@range.begin.format} → #{@range.end.format})"
    end
  end

  def self.parse(input : Array(String)) : {ranges: Array(FreshRange), ingredients: Array(Int128)}
    input.reduce({ranges: [] of FreshRange, ingredients: [] of Int128}) do |acc, line|
      next acc if line.empty?

      if line.includes?("-")
        {ranges: acc[:ranges] << FreshRange.new(line), ingredients: acc[:ingredients]}
      else
        {ranges: acc[:ranges], ingredients: acc[:ingredients] << line.to_i128}
      end
    end
  end

  def self.part_1(input, must_log = false)
    data = parse(input)
    data[:ingredients].count do |ingredient|
      data[:ranges].any? { |range| range.includes?(ingredient) }
    end
  end

  def self.part_2(input, must_log = false)
    data = parse(input)
    puts "Number of FreshRanges: #{data[:ranges].size}" if must_log

    data[:ranges]
      .reduce([] of FreshRange) do |acc, fr|
        if must_log
          puts "⚙️ Processing range #{fr}"
          puts "   Current ranges: #{acc.map(&.to_s)}"
        end

        to_process, to_keep_untouched = acc.partition { |range| range.overlaps_or_consecutive?(fr) }

        puts "    #{to_process.size} ranges to merge, #{to_keep_untouched.size} ranges to leave alone" if must_log

        to_keep_untouched << to_process.reduce(fr) { |acc, range_to_process| acc.merge(range_to_process) }
      end
      .sum { |fr| fr.size }
  end
end
