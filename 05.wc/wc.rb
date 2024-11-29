#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

def main
  opt = OptionParser.new
  options = {}
  opt.on('-l') { |v| options[:l] = v }
  opt.on('-w') { |v| options[:w] = v }
  opt.on('-c') { |v| options[:c] = v }
  files = opt.parse!(ARGV)
  options = { l: true, w: true, c: true } if options == {}

  contents =
    if ARGV.empty?
      { '' => $stdin.readlines.join }
    else
      files.to_h { |file| [file, File.read(file)] }
    end

  print build_count(options, contents).join("\n")
end

def build_count(options, contents)
  lines_count_sum = contents.values.map { |value| value.lines.count }.sum
  words_count_sum = contents.values.map { |value| value.split(/.\s+/).size }.sum
  bytesize_sum = contents.values.map(&:size).sum
  col_width = [lines_count_sum, words_count_sum, bytesize_sum].max.to_s.bytesize # 直すかも

  rows = build_rows(options, contents, col_width)

  return rows unless contents.size > 1

  lastcols = []
  lastcols << "    #{lines_count_sum.to_s.rjust(col_width)}" if options[:l]
  lastcols << "    #{words_count_sum.to_s.rjust(col_width)}" if options[:w]
  lastcols << "    #{bytesize_sum.to_s.rjust(col_width)}" if options[:c]
  lastcols << ' total'
  rows << lastcols.join
end

def build_rows(options, contents, col_width = 0)
  contents.map do |file, content|
    cols = []
    cols << "    #{content.lines.count.to_s.rjust(col_width)}" if options[:l]
    cols << "    #{content.split(/.\s+/).size.to_s.rjust(col_width)}" if options[:w]
    cols << "    #{content.size.to_s.rjust(col_width)}" if options[:c]
    cols << " #{file}"
    cols.join
  end
end

main
