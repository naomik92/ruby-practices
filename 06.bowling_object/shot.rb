#!/usr/bin/env ruby
# frozen_string_literal: true

class Shot
  def initialize(mark)
    @mark = mark
  end

  # ショットのmarkを取り出すメソッド
  def score
    return 10 if @mark == 'X'

    @mark.to_i
  end

  # def to_s
  #   @marks.map do |mark|
  #     if mark == 'X'
  #       mark == 10
  #     end
  #   end
  # end

  # def to_shots
  #   shots = []
  #   @marks.split(',').each do |m|
  #     if m == 'X'
  #       shots << 10
  #       shots << 0
  #     else
  #       shots << m.to_i
  #     end
  #   end
  #   shots
  # end
end
