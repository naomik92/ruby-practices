#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

class LsCommandOption
  def initialize
    @opt = OptionParser.new
  end

  def options
    options = {}
    @opt.on('-a') { |v| options[:a] = v }
    @opt.on('-r') { |v| options[:r] = v }
    @opt.on('-l') { |v| options[:l] = v }
    @opt.parse(ARGV)
    options
  end
end
