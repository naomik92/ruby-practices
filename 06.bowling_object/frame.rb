#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(frame)
    @frame = frame
  end

  def first_shot_score
    Shot.new(@frame[0]).score
  end

  def second_shot_score
    Shot.new(@frame[1]).score
  end

  def third_shot_score
    Shot.new(@frame[2]).score
  end

  def score
    [first_shot_score + second_shot_score + third_shot_score].sum
  end

  # ここにstrikeかspareを判定するメソッドを書いたらよいか。
  # def strike?
  #   @frame[0] == 'X'
  # end

  # def spare
  #   @first_shot
  # end
end

# arr = ['9', '2']
# p Frame.new(arr).score
