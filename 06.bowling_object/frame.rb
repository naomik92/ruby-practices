#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(shots)
    @first_shot = shots[0]
    @second_shot = shots[1]
    @third_shot = shots[2]
  end

  def first_shot_score
    @first_shot.score
  end

  def second_shot_score
    @second_shot.nil? ? 0 : @second_shot.score
  end

  def third_shot_score
    @third_shot.nil? ? 0 : @third_shot.score
  end

  def score
    [first_shot_score, second_shot_score, third_shot_score].sum
  end

  def strike?
    first_shot_score == 10
  end

  def spare?
    first_shot_score != 10 && first_shot_score + second_shot_score == 10
  end
end
