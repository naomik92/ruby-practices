#!/usr/bin/env ruby
# frozen_string_literal: true

class Shot
  def initialize(marks)
    @marks = marks
  end

  def to_shots
    shots = []
    @marks.split(',').each do |m|
      if m == 'X'
        shots << 10
        shots << 0
      else
        shots << m.to_i
      end
    end
    shots
  end
end
