#!/usr/bin/env ruby
require 'optparse'
require 'date'
options = ARGV.getopts('y:', 'm:')

today_year = 
if options['y'] == nil
  Date.today.year
else
  options['y'].to_i
end

today_month =
if options['m'] == nil
  Date.today.mon
else
  options['m'].to_i
end

first_date = Date.new(today_year, today_month, 1)
last_date = Date.new(today_year, today_month, -1)

blanks = []
first_date.wday.times {blanks.push("".rjust(3))}

dates = (first_date..last_date).map do |date|
  date
end

puts "       #{today_month}月 #{today_year}\n"
puts " 日 月 火 水 木 金 土\n"
blanks.each do |blank|
  print blank
end
dates.each do |date|
  print date.day.to_s.rjust(3)
  print "\n" if date.saturday?
end
