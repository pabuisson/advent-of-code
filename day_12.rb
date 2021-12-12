# frozen_string_literal: true

require './advent_day.rb'

class Day12 < AdventDay
  def compute_part_1!
    reached_starts = []
    nodes_to_visit = [Node.new(value: 'end')]

    while (node = nodes_to_visit.pop)
      neighbor_values = neighbors(value: node.value)
      neighbor_values.each do |neighbor|
        neighbor_node = Node.new(value: neighbor, parent: node)
        next unless neighbor_node.visitable?(part: 1)

        node.children << neighbor_node

        if neighbor_node.start?
          reached_starts << neighbor_node
        else
          nodes_to_visit << neighbor_node
        end
      end
    end

    reached_starts.count
  end

  def compute_part_2!
    reached_starts = []
    nodes_to_visit = [Node.new(value: 'end')]

    while (node = nodes_to_visit.pop)
      neighbor_values = neighbors(value: node.value)
      neighbor_values.each do |neighbor|
        neighbor_node = Node.new(value: neighbor, parent: node)
        next unless neighbor_node.visitable?(part: 2)

        node.children << neighbor_node

        if neighbor_node.start?
          reached_starts << neighbor_node
        else
          nodes_to_visit << neighbor_node
        end
      end
    end

    reached_starts.count
  end

  def neighbors(value:)
    @neighbors ||= {}
    @neighbors[value] ||=
      data
      .select { |couple| couple.include?(value) }
      .flat_map { |couple| couple.reject { |v| v == value } }
      .reject { |v| v == 'end' }
  end

  class Node
    attr_reader :value, :children, :parent, :small_cave

    def initialize(value:, parent: nil)
      @value = value
      @children = []
      @parent = parent
      @small_cave = value == (value.downcase)
    end

    def ancestors
      @ancestors ||= (parent.nil? ? [] : [parent] + parent.ancestors)
    end

    def visitable?(part:)
      if part == 1
        large_cave? || not_visited_yet?
      else
        large_cave? || not_visited_yet? || no_small_cave_visited_twice?
      end
    end

    def no_small_cave_visited_twice?
      small_caves_tally = ancestors.select(&:small_cave).map(&:value).tally
      small_caves_tally.all? { |_, count| count < 2 }
    end

    def start?
      value == 'start'
    end

    private

    def not_visited_yet?
      ancestors.none? { |ancestor| ancestor.value == value }
    end

    def large_cave?
      !small_cave
    end
  end

  private

  def format_line(line:)
    line.split('-')
  end
end
