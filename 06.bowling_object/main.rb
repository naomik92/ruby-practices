#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'game'

game = Game.build_from_marks(ARGV[0])
p game.total_score
