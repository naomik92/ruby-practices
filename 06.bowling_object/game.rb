#!/usr/bin/env ruby
# frozen_string_literal: true
require 'debug'
require_relative 'frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def self.build_frames(marks)
    devided_marks = marks.split(/,/).slice_after('X').to_a

    array = []
    devided_marks.each do |devided_mark|
      if devided_mark.size > 2
        devided_mark.each_slice(2).to_a.each do |m|
          array << m
        end
      else
        array << devided_mark
      end
    end

    marks_array = []
    array.each_with_index do |a, idx|
      if idx == 9
        break
      else
        marks_array << a
      end
    end

    if array.size == 12
      marks_array << array[9] + array[10] + array[11]
    elsif array.size == 11
      marks_array << array[9] + array[10]
    else
      marks_array << array[9]
    end
    
    frames = marks_array.map do |marks|
      shots = marks.map do |mark|
        Shot.new(mark)
      end
      Frame.new(shots)
    end

    return Game.new(frames)
  end

  # ゲームのスコアを算出するインスタンスメソッド
  def score
    score = 0
    @frames.each_with_index do |frame, idx|
      score += frame.score
      if idx > 8
        break
      elsif frame.strike?
        score += @frames[idx + 1].first_shot_score + @frames[idx + 1].second_shot_score
      elsif frame.spare?
        score += @frames[idx + 1].first_shot_score
      end
    end
    score
  end
end

game = Game.build_frames('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
p game.score
# puts game.score
