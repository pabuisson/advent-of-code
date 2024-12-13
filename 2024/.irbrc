# frozen_string_literal: true 

Dir.glob('./**/*.rb')
  .reject { |file| file.end_with?('_test.rb') }
  .each { |file| require file }
