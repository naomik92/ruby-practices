#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  def initialize(marks)
    @shots = Shot.new(marks).to_shots
  end

  def to_frames
    @shots.each_slice(2).to_a
  end
end
