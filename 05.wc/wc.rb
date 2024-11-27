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
  if ARGV.empty?
    input = $stdin.readlines
    print build_rows(options, input)
  else
    input = nil
    file_reads = files.to_h { |file| [file, File.read(file)] }
    print build_count(options, input, file_reads).join("\n")
  end
end

def build_count(options, input, file_reads)
  lines_count_sum = file_reads.values.map { |value| value.lines.count }.sum
  words_count_sum = file_reads.values.map { |value| value.split(/.\s+/).size }.sum
  bytesize_sum = file_reads.values.map(&:size).sum
  col_width = [lines_count_sum, words_count_sum, bytesize_sum].max.to_s.bytesize

  rows = file_reads.map do |file, file_read|
    build_rows(options, input, col_width, file, file_read)
  end

  return rows unless file_reads.size > 1

  rows << build_lastcols(options, lines_count_sum, words_count_sum, bytesize_sum, col_width).join
end

def build_rows(options, input, col_width = 0, file = '', file_read = '')
  cols = []
  cols << "    #{input&.size || file_read.lines.count.to_s.rjust(col_width)}" if options[:l]
  cols << "    #{(input&.join(' ') || file_read).split(/.\s+/).size.to_s.rjust(col_width)}" if options[:w]
  cols << "    #{input&.join&.bytesize || file_read.size.to_s.rjust(col_width)}" if options[:c]
  cols << " #{file}"
  cols.join
end

def build_lastcols(options, lines_count_sum, words_count_sum, bytesize_sum, col_width)
  lastcols = []
  lastcols << "    #{lines_count_sum.to_s.rjust(col_width)}" if options[:l]
  lastcols << "    #{words_count_sum.to_s.rjust(col_width)}" if options[:w]
  lastcols << "    #{bytesize_sum.to_s.rjust(col_width)}" if options[:c]
  lastcols << ' total'
end

main
