#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative './mozaic'

i = 1
loop do
  (1..3).each do |columns|
    (1..10).each do |items|
      next if 2 * items < columns

      puts ''
      puts "### (#{i}) - #{items} in #{columns} columns"
      mozaic = Mozaic.create(items, columns)
      puts mozaic
      puts "=> valid? #{mozaic.valid?}\n\n"
      i += 1
    end
  end
end
