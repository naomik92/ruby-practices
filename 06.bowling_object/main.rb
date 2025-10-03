#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

frames = Game.build_frames(ARGV[0])
game = Game.new(frames)
p game.total_score
