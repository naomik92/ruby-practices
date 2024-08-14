#!/usr/bin/env ruby
require 'optparse'
options = ARGV.getopts('y:', 'm:')

require 'date'
t = Date.today

if options['y'] == nil
  t_year = t.year
else
  t_year = options['y'].to_i
end

if options['m'] == nil
  t_month = t.mon
else
  t_month = options['m'].to_i
end

t_lastday = Date.new(t_year, t_month, -1).mday

# カレンダーの日付部分の配列を生成
x = Date.new(t_year, t_month, 1).cwday
enum = Enumerator.new{|y|
  (1..x).each{|i|
    if x == 7
      break
    else
      y << i
    end
  }  
}
arr1 =  enum.map{|i| "   " }.to_a
enum2 = Enumerator.new{|z|
  (1..t_lastday).each{|j|
    if j < 10
      z << " #{j} "
    else
      z << "#{j} "
    end
  }
}
arr2 = enum2.to_a
arr = arr1 + arr2

#　カレンダーの表示
puts "      #{t_month}月 #{t_year}\n"
puts "日 月 火 水 木 金 土\n"
arr.each_index{|a|
  if a % 7 == 0 && a != 0
    print "\n" + arr[a]
  else
    print arr[a]
  end
}