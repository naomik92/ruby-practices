#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  def initialize(frames)
    @frames = frames
  end

  def self.build_from_marks(marks)
    devided_marks_array = marks.split(',').slice_after('X').to_a

    array = []
    devided_marks_array.each do |devided_marks|
      if devided_marks.size > 2
        devided_marks.each_slice(2).to_a.each do |devided_mark_array|
          array << devided_mark_array
        end
      else
        array << devided_marks
      end
    end

    frames = (array[0..8] + [array[9..].flatten]).map do |marks_array|
      shots = marks_array.map do |mark|
        Shot.new(mark)
      end
      Frame.new(shots)
    end

    Game.new(frames)
  end

  def total_score
    score + strike_bonus + spare_bonus
  end

  private

  def score
    @frames.sum(&:score)
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
end
