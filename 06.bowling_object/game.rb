#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  STRIKE_SCORE = 10

  attr_reader :frames

  def initialize(marks)
    @frames = Frame.new(marks).to_frames
  end

  def score
    initial_point = 0
    self.calculate_score(initial_point)
  end

  private

  def calculate_score(point)
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

marks = ARGV[0]
game = Game.new(marks)
puts game.score
