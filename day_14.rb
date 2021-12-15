# frozen_string_literal: true

require './advent_day.rb'

class Day14 < AdventDay
  def compute_part_1!
    template = initialize_template(data: data)
    rules = initialize_rules(data: data)

    couples = template.dup.chars

    10.times do
      couples =
        couples.each_cons(2).flat_map.with_index do |couple, index|
          matching_rule = rules.find { |rule| rule.condition == couple.join('') }

          if index.zero?
            [couple.first, matching_rule.output, couple.last]
          else
            [matching_rule.output, couple.last]
          end
        end
    end

    letters_tally = couples.tally
    most_common = letters_tally.max_by { |_, count| count }
    least_common = letters_tally.min_by { |_, count| count }

    puts "Most common letter: #{most_common}"
    puts "Least common letter: #{least_common}"

    most_common.last - least_common.last
  end

  def compute_part_2!
  end

  private

  def initialize_template(data:)
    data.first
  end

  def initialize_rules(data:)
    data
      .select { |line| line.include?('->') }
      .map do |line|
        condition, output = line.split(' -> ')
        Rule.new(condition: condition, output: output)
      end
  end

  Rule = Struct.new(:condition, :output, keyword_init: true)
end
