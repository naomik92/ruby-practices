#!/usr/bin/env ruby
require 'optparse'
require 'date'
options = ARGV.getopts('y:', 'm:')

today_year = options['y']&.to_i || Date.today.year
today_month = options['m']&.to_i || Date.today.mon

first_date = Date.new(today_year, today_month, 1)
last_date = Date.new(today_year, today_month, -1)

blanks = []
first_date.wday.times {blanks.push("".rjust(3))}

puts "       #{today_month}月 #{today_year}\n"
puts " 日 月 火 水 木 金 土\n"
print blanks.join
(first_date..last_date).each do |date|
  print date.day.to_s.rjust(3)
  print "\n" if date.saturday?
end
