# frozen_string_literal: true

require './advent_day.rb'

class Day15 < AdventDay
  def compute_part_1!
    cave = Cave.new(data: data)
    dijkstra(cave: cave)
  end

  def compute_part_2!
    cave = CavePart2.new(data: data)
    dijkstra(cave: cave)
  end

  private

  def dijkstra(cave:)
    visited_nodes = {}
    nodes_to_visit = { cave.start_point => PathNode.new(point: cave.start_point, parent: nil, path_risk: 0) }

    while nodes_to_visit.any?
      less_risky_node_to_visit = nodes_to_visit.min_by { |_, path_node| path_node.path_risk }
      processed_node = nodes_to_visit.delete(less_risky_node_to_visit.first)

      processed_node.point.neighbors(map: cave.map).each do |neighbor|
        next if visited_nodes.key?(neighbor)

        neighbor_path_risk = processed_node.path_risk + neighbor.risk

        if (former_node = nodes_to_visit[neighbor])
          if former_node.path_risk > neighbor_path_risk
            former_node.update(parent: processed_node, path_risk: neighbor_path_risk)
          end
        else
          nodes_to_visit[neighbor] =
            PathNode.new(point: neighbor, parent: processed_node, path_risk: neighbor_path_risk)
        end
      end

      visited_nodes[processed_node.point] = processed_node
      puts "Visited: #{visited_nodes.size} / To visit: #{nodes_to_visit.size}" if (visited_nodes.size % 1000).zero?
    end

    visited_nodes[cave.end_point].path_risk
  end

  class Cave
    attr_reader :map

    def initialize(data:)
      @map =
        data.map.with_index do |line, y|
          line.chars.map.with_index do |risk, x|
            Point.new(x: x, y: y, risk: risk.to_i)
          end
        end
      @max_rows = @map.size
      @max_cols = @map.first.size
    end

    def start_point
      @map[0][0]
    end

    def end_point
      @map[@max_rows - 1][@max_cols - 1]
    end

    def nodes_count
      @max_rows * @max_cols
    end
  end

  class CavePart2 < Cave
    def initialize(data:)
      @map = []
      data_rows = data.size
      data_cols = data.first.size

      5.times do |i|
        data.each.with_index do |line, y|
          new_line = []
          5.times do |j|
            new_line += line.chars.map.with_index do |risk, x|
              row = i * data_rows + y
              col = j * data_cols + x
              Point.new(x: col, y: row, risk: risk.to_i + i + j)
            end
          end

          @map << new_line
        end
      end

      @max_rows = @map.size
      @max_cols = @map.first.size
    end
  end

  class Point
    attr_reader :x, :y, :risk

    def initialize(x:, y:, risk:)
      @x = x
      @y = y
      @risk = risk > 9 ? risk % 9 : risk
    end

    def neighbors(map:)
      neighbors = []
      neighbors << map[y - 1][x] if y.positive?
      neighbors << map[y + 1][x] if y < map.size - 1
      neighbors << map[y][x - 1] if x.positive?
      neighbors << map[y][x + 1] if x < map.first.size - 1

      neighbors
    end

    # For array include?
    def ==(other)
      x == other.x && y == other.y
    end

    # For hash check
    def eql?(other)
      x == other.x && y == other.y
    end

    # For hash check
    def hash
      x * 10_000 + y
    end

    def to_s
      "x:#{x}, y:#{y}, risk: #{risk}"
    end
  end

  class PathNode
    attr_accessor :point, :parent, :path_risk

    def initialize(point:, parent:, path_risk:)
      @point = point
      @parent = parent
      @path_risk = path_risk
    end

    def update(parent:, path_risk:)
      self.parent = parent
      self.path_risk = path_risk
    end

    def to_s
      "Point(#{point}), risk: #{path_risk}"
    end
  end
end
