#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def self.build_frames(marks)
    devided_marks = marks.split(',').slice_after('X').to_a

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
      break if idx == 9

      marks_array << a
    end

    marks_array <<
      if array.size == 12
        array[9] + array[10] + array[11]
      elsif array.size == 11
        array[9] + array[10]
      else
        array[9]
      end

    frames = marks_array.map do |m|
      shots = m.map do |mark|
        Shot.new(mark)
      end
      Frame.new(shots)
    end

    Game.new(frames)
  end

  def score
    score = 0
    @frames.each do |frame|
      score += frame.score
    end
    score
  end

  def strike_bonus
    bonus_score = 0
    @frames.each_with_index do |frame, idx|
      if idx > 8
        break
      elsif idx < 8 && frame.strike? && @frames[idx + 1].strike?
        bonus_score += @frames[idx + 1].first_shot_score + @frames[idx + 2].first_shot_score
      elsif frame.strike?
        bonus_score += @frames[idx + 1].first_shot_score + @frames[idx + 1].second_shot_score
      end
    end
    bonus_score
  end

  def spare_bonus
    bonus_score = 0
    @frames.each_with_index do |frame, idx|
      if idx > 8
        break
      elsif frame.spare?
        bonus_score += @frames[idx + 1].first_shot_score
      end
    end
    bonus_score
  end

  def total_score
    score + strike_bonus + spare_bonus
  end
end
