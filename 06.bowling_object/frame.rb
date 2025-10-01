#!/usr/bin/env ruby
# frozen_string_literal: true
require 'debug'
require_relative 'shot'

class Frame
  def initialize(shots)
    @shots = shots # これ要る？
    @first_shot = shots[0] # new
    @second_shot = shots[1] # new
    @third_shot = shots[2] # new
  end

  def first_shot_score
    @first_shot.score
  end

  def second_shot_score
    @second_shot.score
  end

  def score
    if @second_shot.nil?
      @first_shot.score
    elsif @third_shot.nil?
      [@first_shot.score, @second_shot.score].sum
    else
      [@first_shot.score, @second_shot.score, @third_shot.score].sum
    end
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    @first_shot.score != 10 && @first_shot.score + @second_shot.score == 10
  end
end

# frame = ["7", "3"]
# array = frame.map do |f|
#   Shot.new(f)
# end
# p array

