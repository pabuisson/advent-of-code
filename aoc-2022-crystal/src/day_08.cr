class Aoc2022::Day08
  def self.part_1(input)
    whole_map = format(input)

    max_y = whole_map.height
    max_x = whole_map.width

    visible_map =
      Map.new(
      (0...max_y).map_with_index do |y|
        (0...max_x).map_with_index do |x|
          visible_from_outside?(row_index: y, col_index: x, map: whole_map) ? 1 : 0
        end
      end
    )

    visible_map.count_values(value: 1)
  end

  def self.part_2(input)
    whole_map = format(input)
    max_y = whole_map.height - 1
    max_x = whole_map.width - 1

    scenic_score_map =
      Map.new(
        (1...max_y).map_with_index do |y|
          (1...max_x).map_with_index do |x|
            scenic_score?(row_index: y, col_index: x, map: whole_map)
          end
        end
      )

    scenic_score_map.highest_value
  end

  def self.format(input)
    Map.new(map:
      input.split("\n", remove_empty: true).map do |line|
        line.chars.map { |c| c.to_i }
      end
    )
  end

  def self.visible_from_outside?(row_index, col_index, map)
    tree = map.at(x: col_index, y: row_index)
    max_x = map.height - 1
    max_y = map.width - 1

    visible_from_left = (0..col_index - 1).all? { |x| map.at(y: row_index, x: x) < tree }
    visible_from_right = ((col_index + 1)..max_x).all? { |x| map.at(y: row_index, x: x) < tree }
    visible_from_top = (0..row_index - 1).all? { |y| map.at(y: y, x: col_index) < tree }
    visible_from_bottom = ((row_index + 1)..max_y).all? { |y| map.at(y: y, x: col_index) < tree }

    visible_from_left || visible_from_right || visible_from_top || visible_from_bottom
  end

  def self.scenic_score?(row_index, col_index, map)
    tree = map.at(x: col_index, y: row_index)
    max_x = map.height - 1
    max_y = map.width - 1

    visible_from_left = (0..col_index - 1).to_a.reverse.reduce(0) do |acc, x|
      is_smaller = map.at(y: row_index, x: x) < tree
      is_smaller ? acc + 1 : break acc + 1
    end

    visible_from_right = ((col_index + 1)..max_x).reduce(0) do |acc, x|
      is_smaller = map.at(y: row_index, x: x) < tree
      is_smaller ? acc + 1 : break acc + 1
    end

    visible_from_top = (0..row_index - 1).to_a.reverse.reduce(0) do |acc, y|
      is_smaller = map.at(y: y, x: col_index) < tree
      is_smaller ? acc + 1 : break acc + 1
    end

    visible_from_bottom = ((row_index + 1)..max_y).reduce(0) do |acc, y|
      is_smaller = map.at(y: y, x: col_index) < tree
      is_smaller ? acc + 1 : break acc + 1
    end

    visible_from_left * visible_from_right * visible_from_top * visible_from_bottom
  end

  class Map
    private getter map : Array(Array(Int32))

    def initialize(map)
      @map = map
    end

    def width
      map.first.size
    end

    def height
      map.size
    end

    def count_values(value)
      map.sum { |row| row.count(value) }
    end

    def highest_value
      map.flat_map { |row| row.max }.max
    end

    def at(x, y)
      map[y][x]
    end

    def to_s
      map.map { |row| row.join("") }.join("\n")
    end
  end
end
