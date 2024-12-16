# frozen_string_literal: true

require './advent_day'
require 'debug'

class Day05 < AdventDay
  def part_1!
    parsed_data = Parser.new(@data)

    parsed_data.updates
      .map { Update.new(_1) }
      .select { |update| update.correct?(parsed_data.ordering_rules) }
      .map { |update| update.middle_value }
      .sum
  end

  def part_2!
    parsed_data = Parser.new(@data)

    parsed_data.updates
      .map { Update.new(_1) }
      .select { |update| !update.correct?(parsed_data.ordering_rules) }
      .map { |incorrect_update| incorrect_update.reordered(parsed_data.ordering_rules) }
      .map { |update| update.middle_value  }.sum
  end


  class Update
    def initialize(update)
      @update = update
    end

    def correct?(rules)
      is_correct = true

      update.each_with_index do |page, page_index|
        relevant_rules = rules.select { _1[0] == page }
        authorized_next_pages = relevant_rules.map { _1[1] }
        following_pages = update[(page_index+1)..-1]

        if following_pages.any? { |p| !authorized_next_pages.include?(p) }
          is_correct = false
          break
        end
      end

      is_correct
    end

    def reordered(rules)
      relevant_rules = rules.select { update.include?(_1[0]) && update.include?(_1[1]) }
      reordered_update = []

      while relevant_rules != []
        first_page = update.find { |page| !reordered_update.include?(page) && relevant_rules.none? { _1[1] == page }}
        reordered_update << first_page
        relevant_rules = relevant_rules.select { _1[0] != first_page } 

        # Because after adding the 2nd to last items, relevant rules would be empty
        # and the reordered update array would be missing the last item
        if relevant_rules == []
          last_item = update - reordered_update
          reordered_update = reordered_update + last_item
        end
      end

      Update.new(reordered_update)
    end

    def middle_value = update[(update.size - 1) / 2]

    private

    attr_reader :update
  end


  class Parser
    attr_reader :ordering_rules, :updates

    def initialize(data)
      @ordering_rules = []
      @updates = []

      current_section = 1
      data.each do |line| 
        if line.empty?
          current_section = 2
          next
        elsif current_section == 1
          @ordering_rules << line.split('|').map(&:to_i)
        elsif current_section == 2
          @updates << line.split(',').map(&:to_i)
        else 
          raise "We should not reach this branch"
        end
      end
    end
  end
end
