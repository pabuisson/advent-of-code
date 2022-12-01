# frozen_string_literal: true

require './advent_day.rb'

class Day14 < AdventDay
  def compute_part_1!
    template = initialize_template(data: data)
    rules = initialize_rules(data: data)
    couples = template.dup.chars

    10.times do
      all_but_first_char = couples.each_cons(2).flat_map do |couple|
        joined_couple = couple.join('')
        [rules[joined_couple], couple.last]
      end

      couples = [couples[0]] + all_but_first_char
    end

    count_by_couples = couples.each_cons(2).map { |couple| couple.join('') }.tally
    compute_print_and_return_score(count_by_couples: count_by_couples)
  end

  def compute_part_2!
    template = initialize_template(data: data)
    rules = initialize_rules_as_structs(data: data)
    couples = template.chars
                      .each_cons(2)
                      .each_with_object(Hash.new(0)) { |couple, hash| hash[couple.join('')] = 1 }

    40.times do
      delta = couples.each_with_object(Hash.new(0)) do |(couple, count), delta|
        # "consume" the couple to generate two new couples
        delta[couple] -= count
        # increment the count for the 2 couples generated from the origin couple
        delta[rules[couple].left_side] += count
        delta[rules[couple].right_side] += count
      end

      delta.each { |couple, count| couples[couple] += count }
    end

    compute_print_and_return_score(count_by_couples: couples)
  end

  private

  def compute_print_and_return_score(count_by_couples:)
    tally = count_by_couples.each_with_object(Hash.new(0)) do |(couple, count), tally|
              tally[couple.chars.first] += count
              tally[couple.chars.last] += count
            end

    most_common = tally.max_by { |_, count| count }
    least_common = tally.min_by { |_, count| count }

    # letters are stored in count_by_couples twice: once as 1st letter of a couple, and once as last letter of a couple
    # therefore, we need to divide all counts by 2
    # but chars at 1st and last position have one fewer occurrence than in the middle of the string
    # instead of removing 1 then dividing by 2 then re-adding 1, we can divide by 2 and use ceil
    #
    # for template => ABBC
    # count_by_couples = AB => 1, BB => 1, BC => 1
    # letters => A=1x, B=4x, C=1x
    # count => A=0.5.ceil=1, B=2, C=0.5.ceil=1
    most_common_count = (most_common.last.to_f / 2).ceil
    least_common_count = (least_common.last.to_f / 2).ceil

    puts "Most common letter: #{most_common.first} x#{most_common_count}"
    puts "Least common letter: #{least_common.first} x#{least_common_count}"

    most_common_count - least_common_count
  end

  def initialize_template(data:)
    data.first
  end

  def initialize_rules(data:)
    data
      .select { |line| line.include?('->') }
      .each_with_object({}) do |line, hash|
        condition, output = line.split(' -> ')
        hash[condition] = output
      end
  end

  Rule = Struct.new(:couple, :inserted_char, keyword_init: true) do
    def left_side
      [couple.chars.first, inserted_char].join('')
    end

    def right_side
      [inserted_char, couple.chars.last].join('')
    end
  end

  def initialize_rules_as_structs(data:)
    data
      .select { |line| line.include?('->') }
      .each_with_object({}) do |line, hash|
        condition, inserted_char = line.split(' -> ')
        hash[condition] = Rule.new(couple: condition, inserted_char: inserted_char)
      end
  end
end
