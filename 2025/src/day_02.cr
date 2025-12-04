require "./base"

class Day02 < Base
  struct Number
    property value : Int64
    property value_as_string : String

    def initialize(@value : Int64)
      @value_as_string = @value.to_s
    end

    # Part 1
    def skippable?
      @value_as_string.size % 2 != 0
    end

    # Part 2
    # skippable if can't be split in only multiples of size
    def skippable?(for_size : Int32)
      return false if for_size == 1
      @value_as_string.size % for_size != 0
    end

    # Part 1
    def invalid?
      left == right
    end

    private def left
      @value_as_string[0, (@value_as_string.size / 2).to_i]
    end

    private def right
      @value_as_string[(@value_as_string.size / 2).to_i..]
    end

    # Part 2
    def invalid?(for_size : Int32)
      @value_as_string
        .chars
        .in_slices_of(for_size)
        .each_cons_pair { |current, next_part| return false if current != next_part }

      true
    end
  end

  def self.part_1(input, must_log = false)
    input
      .first
      .split(",")
      .map { |couple| couple.split("-").map(&.to_i64) }
      .flat_map do |(from, to)|
        puts "(#{from} – #{to})" if must_log

        (from..to)
          .map { |n| Number.new(n) }
          .select { |number| !number.skippable? && number.invalid? }
          .map(&.value)
      end
      .sum
  end

  def self.part_2(input, must_log = false)
    input
      .first
      .split(",")
      .map { |couple| couple.split("-").map(&.to_i64) }
      .flat_map do |(from, to)|
        puts "(#{from} – #{to})" if must_log

        (from..to)
          .map { |n| Number.new(n) }
          .compact_map do |number|
            puts "Number: #{number.value_as_string}" if must_log
            (1..number.value_as_string.size / 2).each do |size|
              puts "\tTesting for size #{size}" if must_log

              next if number.skippable?(for_size: size)
              break number if number.invalid?(for_size: size)
            end
          end
          .map(&.value)
      end
      .sum
  end
end
