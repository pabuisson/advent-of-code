# frozen_string_literal: true

require 'rake/testtask'
require 'ruby-prof'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['*_test.rb']
end

task :run, [:day, :profile] do |_, args|
  file_name = "./day_#{args[:day]}.rb"
  require file_name

  class_name = "Day#{args[:day]}"
  class_const = Object.const_get(class_name)
  puts "Day #{args[:day]}".center(10, '-')

  prof_part_1 = RubyProf.profile do
    puts "❇️  Part 1 => #{class_const.new.compute_part_1!}"
  end
  print_profile(part: 1, profile: prof_part_1) if profile?(args)

  prof_part_2 = RubyProf.profile do
    puts "🔥 Part 2 => #{class_const.new.compute_part_2!}"
  end
  print_profile(part: 2, profile: prof_part_2) if profile?(args)
end

task default: :test

def profile?(args)
  %w[1 true].include?(args[:profile])
end

def print_profile(part:, profile:)
  puts "Profile part #{part}".center(50, '=')
  printer = RubyProf::FlatPrinter.new(profile)
  printer.print($stdout, min_percent: 5)
  puts '-'.center(50, '-')
end
