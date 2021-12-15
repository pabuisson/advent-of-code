# frozen_string_literal: true

require './advent_day.rb'

class Day15 < AdventDay
  # def compute_part_1
  #   map = initialize_map(data: data)
  #   # TODO: try a BFS instead, with no heuristic?
  # end

  def compute_part_1!
    map = initialize_map(data: data)

    closed_list = []
    opened_list = [map[0][0]]

    while opened_list.any?
      processed_node = opened_list.sort_by!(&:fcost).shift

      if processed_node.end?
        print_map(map: map)
        puts "🥳 Arrived to the final node! #{processed_node.gcost}"
        break
      end

      processed_node.neighbors(map: map).each do |neighbor|
        exists_in_closed_list = closed_list.any? { |node| node.x == neighbor.x && node.y == neighbor.y }
        next if exists_in_closed_list

        neighbor.gcost = processed_node.gcost + neighbor.risk
        neighbor.hcost = hcost(from: neighbor, to: map[9][9], map: map)

        puts "from: #{processed_node}, to: #{neighbor}, hcost = #{neighbor.hcost}"

        # If new path of neighbor is shorter
        # Or neighbor not in open list
        same_node_in_open_list = opened_list.find { |open| open.x == neighbor.x && open.y == neighbor.y }
        if same_node_in_open_list.nil? || neighbor.gcost < same_node_in_open_list.gcost
          if same_node_in_open_list
            same_node_in_open_list.gcost = neighbor.gcost
            same_node_in_open_list.hcost = neighbor.hcost
          else
            opened_list << neighbor
          end
        end
      end

      closed_list << processed_node
    end
  end

  def compute_part_2!
  end

  private

  def hcost(from:, to:, map:)
    (to.x - from.x)**2 + (to.y - from.y)**2
  end

  def print_map(map:)
    puts
    map.each_with_index do |line|
      puts line.map { ''.center(7) }.join('|') + '|'
      puts line.map { |node| node.risk.to_s.center(7) }.join('|') + '|'
      puts line.map { ''.center(7) }.join('|') + '|'
      puts line.map { |node| "#{node.gcost.to_s.rjust(3)},#{node.hcost.to_s.rjust(3)}" }.join('|') + '|'
      puts line.map { ''.center(7) }.join('|') + '|'
      puts line.map { '--------' }.join('') + '-'
    end
  end

  class Node
    attr_accessor :gcost, :hcost
    attr_reader :x, :y, :risk

    def initialize(x:, y:, risk:, gcost: 0, hcost: 0)
      @x = x
      @y = y
      @risk = risk
      @gcost = gcost
      @hcost = hcost
    end

    def neighbors(map:)
      neighbors = []
      neighbors << map[y - 1][x] if y.positive?
      neighbors << map[y + 1][x] if y < map.size - 1
      neighbors << map[y][x - 1] if x.positive?
      neighbors << map[y][x + 1] if x < map.first.size - 1

      neighbors
    end

    def fcost
      return -1 if gcost.nil? || hcost.nil?

      gcost + hcost
    end

    def end?
      x == 9 && y == 9
    end

    def to_s
      "x=#{x},y=#{y} :: risk=#{risk}"
    end
  end

  def initialize_map(data:)
    data.map.with_index do |line, y|
      line.chars.map.with_index do |risk, x|
        Node.new(x: x, y: y, risk: risk.to_i)
      end
    end
  end
end
