#!/usr/bin/env ruby
# frozen_string_literal: true

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

    frames = []
    array.each_with_index do |a, idx|
      if idx == 9
        break
      else
        frames << a
      end
    end

    if array.size == 12
      frames << array[9] + array[10] + array[11]
    elsif array.size == 11
      frames << array[9] + array[10]
    else
      frames << array[9]
    end
    p frames
    # after_frames = frames.map {}
  end

  # フレームを構築するメソッド
#   def build_frames
#     shots = []
#     @marks.split(/,/).each do |m|
#       shots << m
#       if m == 'X'
#         shots << '0'
#       end
#     end
    
#     shots.each_slice(2).to_a.map do |frame|
#       Frame.new(frame)
#     end
#   end

#   # ゲームのスコアを算出するメソッド
#   def score
#     frames = build_frames
#     score = 0
#     frames.each_with_index do |frame, idx|
#       score += frame.score
#       if frames[idx - 1].strike?
#         score += frame.score
#       elsif frames[idx - 1].spare?
#         score += frame.first_shot_score
#       end
#     end
#     score
#   end
end

game = Game.build_frames('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
# puts game.score
