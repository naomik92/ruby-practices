#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  STRIKE_SCORE = 10

  def initialize(marks)
    @marks = marks
  end

  # フレームを構築するメソッド
  def build_frames
    array = []
    @marks.split(/,/).each do |m|
      array << m
      if m == 'X'
        array << '0'
      end
    end
    
    array.each_slice(2).to_a.map do |a|
      Frame.new(a)
    end
  end

  # ゲームのスコアを算出するメソッド
  def score
    frames = build_frames
    score = 0
    frames.each_with_index do |frame, idx|
      score += frame.score
      if frames[idx - 1].first_shot_score == STRIKE_SCORE
        score += frame.score
      elsif frames[idx - 1].score == 10
        score += frame.first_shot_score
      end
    end
    score
  end
end

game = Game.new('X,9,1,6,2')
p game.score
