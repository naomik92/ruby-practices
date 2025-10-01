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
