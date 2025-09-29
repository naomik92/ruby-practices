#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

game = Game.build_frames(ARGV[0])
puts game.score

# array = []
# devided_marks.each do |devided_mark|
#   if devided_mark.size > 2
#     devided_mark.each_slice(2).to_a.each do |m|
#       array << m
#     end
#   else
#     array << devided_mark
#   end
# end

# frames = []
# array.each_with_index do |a, idx|
#   if idx == 9
#     break
#   else
#     frames << a
#   end
# end

# if array.size == 12
#   frames << array[9] + array[10] + array[11]
# elsif array.size == 11
#   frames << array[9] + array[10]
# else
#   frames << array[9]
# end

# puts game.score
