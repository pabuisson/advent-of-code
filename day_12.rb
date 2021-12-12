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
        next unless neighbor_node.visitable?

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
  end

  def neighbors(value:)
    data
      .select { |couple| couple.include?(value) }
      .flat_map { |couple| couple.reject { |v| v == value } }
      .reject { |v| v == 'end' }
  end

  class Node
    attr_reader :value, :children, :parent

    def initialize(value:, parent: nil)
      @value = value
      @children = []
      @parent = parent
    end

    def ancestors
      ancestors = []
      node = self
      while node.parent
        ancestors << node.parent
        node = node.parent
      end

      ancestors
    end

    def visitable?
      return true unless small_cave?

      not_visited_yet?
    end

    def start?
      value == 'start'
    end

    private

    def not_visited_yet?
      ancestors.none? { |ancestor| ancestor.value == value }
    end

    def small_cave?
      value == value.downcase
    end
  end

  private

  def format_line(line:)
    line.split('-')
  end
end
