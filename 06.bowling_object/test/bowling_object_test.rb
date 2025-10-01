#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../game'

class BowlingObjectTest < Minitest::Test
  def test_point1
    marks = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5'
    game = Game.build_frames(marks)
    assert_equal 139, game.score
  end

  def test_point2
    marks = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X'
    game = Game.build_frames(marks)
    assert_equal 164, game.score
  end

  def test_point3
    marks = '0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4'
    game = Game.build_frames(marks)
    assert_equal 107, game.score
  end

  def test_point4
    marks = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0'
    game = Game.build_frames(marks)
    assert_equal 134, game.score
  end

  def test_point5
    marks = '6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8'
    game = Game.build_frames(marks)
    assert_equal 144, game.score
  end

  def test_point6
    marks = 'X,X,X,X,X,X,X,X,X,X,X,X'
    game = Game.build_frames(marks)
    assert_equal 300, game.score
  end

  def test_point7
    marks = 'X,X,X,X,X,X,X,X,X,X,X,2'
    game = Game.build_frames(marks)
    assert_equal 292, game.score
  end

  def test_point8
    marks = 'X,0,0,X,0,0,X,0,0,X,0,0,X,0,0'
    game = Game.build_frames(marks)
    assert_equal 50, game.score
  end
end
