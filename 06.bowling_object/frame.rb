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

  # そもそもthird_shot_scoreは存在するのか。
  def score
    third_shot_score = Shot.new(@frame[2]).score
    [first_shot_score + second_shot_score + third_shot_score].sum
  end

  def strike?
    first_shot_score == 10
  end

  def spare?
    first_shot_score != 10 && first_shot_score + second_shot_score == 10
  end
end

arr = ['3', '3']
p Frame.new(arr).score
