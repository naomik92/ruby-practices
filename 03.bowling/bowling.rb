#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0
frames.each_with_index do |frame, idx|
  point += frame.sum
  if idx >= 9
    next
  elsif frame[0] == 10 && frames[idx + 1][0] == 10
    point += frames[idx + 1][0] + frames[idx + 2][0]
  elsif frame[0] == 10
    point += frames[idx + 1][0] + frames[idx + 1][1]
  elsif frame.sum == 10
    point += frames[idx + 1][0]
  end
end

puts point
