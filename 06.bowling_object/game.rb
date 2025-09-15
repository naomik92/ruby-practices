#!/usr/bin/env ruby
# frozen_string_literal: true

class Game
  # scores = ARGV[0].split(',')
  # puts point
end

class Shot
  attr_reader :marks
  def initialize(marks)
    @marks = marks
  end

  def to_a
    shots = []
    marks.split(',').each do |m|
      if m == 'X'
        shots << 10
        shots << 0
      else
        shots << m.to_i
      end
    end
    shots
  end
end

class Frame
  attr_reader :shots
  def initialize(shots)
    @shots = shots
  end

  # 適当なメソッド名なので注意
  def divide
    shots.each_slice(2).to_a
  end
end

class Point
  STRIKE_SCORE = 10

  attr_reader :frames
  def initialize(frames)
    @frames = frames
  end

  def calculate
    point = 0
    frames.each_with_index do |frame, idx|
      point += frame.sum
      if idx >= 9
        next
      elsif frame[0] == STRIKE_SCORE && frames[idx + 1][0] == STRIKE_SCORE
        point += frames[idx + 1][0] + frames[idx + 2][0]
      elsif frame[0] == STRIKE_SCORE
        point += frames[idx + 1][0] + frames[idx + 1][1]
      elsif frame.sum == 10
        point += frames[idx + 1][0]
      end
    end
    point
  end
end
