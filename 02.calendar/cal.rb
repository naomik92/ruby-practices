#!/usr/bin/env ruby
require 'optparse'
options = ARGV.getopts('y:', 'm:')

require 'date'

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

# カレンダーの日付部分の配列を生成
blank = []
if first_date.cwday != 7
  first_date.cwday.times {blank.push("".rjust(3))}
end

dates = []
(first_date..last_date).map{|date|
  dates << date.day.to_s.rjust(3)
}

blank_and_dates = blank + dates

#　カレンダーの表示
puts "       #{today_month}月 #{today_year}\n"
puts " 日 月 火 水 木 金 土\n"
blank_and_dates.each_with_index{|str, index|  
  print str
  if (index - 6) % 7 == 0
    print "\n"
  end
}
