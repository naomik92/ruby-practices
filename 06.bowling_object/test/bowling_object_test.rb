# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../game'

class BowlingObjectTest < Minitest::Test
  def test
    shots = Shot.new('X,X,X,X,X,X,X,X,X,X,X,X')
    frames = Frame.new(shots.to_a)
    point = Point.new(frames.divide)
    assert_equal 300, point.calculate
  end
end
