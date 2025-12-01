require "option_parser"

class Base
  enum Part
    One
    Two
  end

  macro inherited
    # Only runs when this file is executed directly with:
    # $ crystal run src/day_01.cr
    #
    # To run the day file in verbose move, use -v or --verbose:
    # $ crystal run src/day_01.cr -- -v
    {% class_name = @type.name.stringify %}
    {% day_num = class_name.gsub(/Day/, "") %}

    if PROGRAM_NAME.includes?("day_#{{{ day_num }}}")
      input = File.read_lines("data/day_#{{{day_num}}}.txt")

      must_log = false
      OptionParser.parse do |parser|
        parser.on("-v", "--verbose", "Enable logging") { must_log = true }
      end

      puts "-" * 50
      puts "🌲 Part 1: #{ {{ @type }}.part_1(input, must_log: must_log)}".center(50)
      puts "-" * 50
      puts "🎄 Part 2: #{ {{ @type }}.part_2(input, must_log: must_log)}".center(50)
      puts "-" * 50
    end
  end
end
