require "big"

class Aoc2022::Day15
  def self.part_1(input, line : Int32, log = false)
    sensors = format(input)
    coverage_array = sensors.map(&.coverage)

    target_line_coverage =
      coverage_array
        .select { |coverage| coverage.has_key?(line) }
        .map { |coverage| coverage[line] }
        .reduce([] of Int32) { |acc, range| acc += range.to_a }
        .sort

    beacons_x_at_target_line =
      sensors
      .map(&.beacon_position)
      .select { |position| position.y == line }
      .map(&.x)

    (target_line_coverage.uniq + beacons_x_at_target_line).size
  end

  def self.part_2(input, max_x_and_y : Int32, log = false)
    sensors = format(input)
    coverage_array = sensors.map(&.coverage)

    # the distress beacon must have x and y coordinates each no lower than 0 and no larger than 4000000.
    (0..max_x_and_y).each do |y|
      if y % 500_000 == 0
        puts "Line #{y} / #{Time.local.to_s}"
        sleep 1
      end

      line_coverage =
        coverage_array
        .compact_map { |coverage| coverage[y] if coverage.has_key?(y) }
        .reject { |range| range.end < 0 || range.begin > max_x_and_y }

      beacons_x_for_line =
        sensors
        .map(&.beacon_position)
        .select { |position| position.y == y }
        .map(&.x)

      reduced_ranges = reduce_ranges(min: 0, max: max_x_and_y, ranges: line_coverage)
      if reduced_ranges.size > 1
        x = reduced_ranges.first.end + 1
        puts "found it! at x=#{x} y=#{y}"
        return Beacon.new(position: Position.new(x: x, y: y)).tuning_frequency
      end
    end
  end

  class Timer
    def initialize
      @last_reference = Time.monotonic
    end

    def reset
      @last_reference = Time.monotonic
    end

    def get_time_and_reset
      (Time.monotonic - @last_reference).tap { reset }
    end
  end

  def self.reduce_ranges(min, max, ranges)
    range_covering_everything = ranges.find { |r| r.begin <= min && r.end >= max }
    return [range_covering_everything] if range_covering_everything

    ranges_to_return =
      begin
        ranges_without_out_of_bonds = ranges.reject { |range| ranges.any? { |r| range.begin > r.begin && range.end < r.end }}

        if ranges_without_out_of_bonds.one?
          ranges_without_out_of_bonds
        else
          ranges_without_out_of_bonds
            .reject do |range|
              ranges_without_out_of_bonds
                .reject { |r| r == range }
                .any? { |r| r.begin <= range.begin && r.end >= range.end }
            end
            .sort_by(&.begin)
            .reduce([] of Range(Int32, Int32)) do |ranges, range|
              next [range] if ranges.empty?

              last_range = ranges.pop
              ranges + (last_range.end >= range.begin - 1 ? [(last_range.begin..range.end)] : [last_range, range])
            end
        end
      end

    ranges_to_return
      .map { |range| range.begin < min ? (min..range.end) : range }
      .map { |range| range.end > max ? (range.begin..max) : range }
  end

  def self.format(input : String)
    input
      .split("\n", remove_empty: true)
      .map do |line|
        match = line.match(/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/).not_nil!
        sensor_x, sensor_y, beacon_x, beacon_y = match.captures

        next if sensor_x.nil? || sensor_y.nil? || beacon_x.nil? || beacon_y.nil?

        Sensor.new(
          position: Position.new(x: sensor_x.to_i, y: sensor_y.to_i),
          beacon_position: Position.new(x: beacon_x.to_i, y: beacon_y.to_i)
        )
    end.compact
  end

  class Sensor
    private getter position
    getter beacon_position

    def initialize(@position : Position, @beacon_position : Position)
    end

    def coverage : Hash(Int32, Range(Int32, Int32))
      # top -> bottom
      delta_x = (position.x - beacon_position.x).abs
      delta_y = (position.y - beacon_position.y).abs

      min_x = position.x - (delta_x + delta_y)
      max_x = position.x + (delta_x + delta_y)

      covered = Hash(Int32, Range(Int32, Int32)).new
      covered_y_delta = 0
      while min_x <= max_x
        covered[position.y + covered_y_delta] = (min_x..max_x)
        covered[position.y - covered_y_delta] = (min_x..max_x)

        covered_y_delta += 1
        min_x +=1
        max_x -= 1
      end

      covered
    end
  end

  class Beacon
    private getter position

    def initialize(@position : Position)
    end

    def tuning_frequency
      BigInt.new(position.x) * 4_000_000 + BigInt.new(position.y)
    end
  end

  struct Position
    getter x, y

    def initialize(@x : Int32, @y : Int32)
    end
  end
end
