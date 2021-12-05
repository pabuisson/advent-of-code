# frozen_string_literal: true

class AdventDay
  def initialize(io: data_file)
    @data = format_data(io: io)
  end

  private

  attr_reader :data

  def format_data(io:)
    io.readlines.map(&:chomp).map do |chomped_line|
      format_line(line: chomped_line)
    end
  end

  def format_line(line:)
    line
  end

  def data_file
    File.open(data_filename)
  rescue Errno::ENOENT => e
    puts "Expected to find data file #{data_filename}, but it does not exist"
  end

  def data_filename
    camel_case_full_class = self.class.name
    camel_case_class = camel_case_full_class.split('::').last
    snake_case_class = camel_case_class.gsub(/(.)([[:upper:]]|\d)/, '\1_\2').downcase
    "data/#{snake_case_class}.txt"
  end
end
