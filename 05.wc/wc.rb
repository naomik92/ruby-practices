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
    print build_input_count(input)
  else
    file_reads = files.to_h { |file| [file, File.read(file)] }
    print build_count(options, file_reads).join("\n")
  end
end

def build_input_count(input)
  cols = []
  cols << "     #{input.size}"
  cols << "     #{input.join(' ').split(/\s+/).size}"
  cols << "    #{input.join.bytesize}"
  cols.join
end

def build_count(options, file_reads)
  lines_count_sum = file_reads.values.map { |value| value.lines.count }.sum
  words_count_sum = file_reads.values.map { |value| value.split(/\s+/).size }.sum
  bytesize_sum = file_reads.values.map(&:size).sum

  rows = build_rows(options, lines_count_sum, words_count_sum, bytesize_sum, file_reads)

  return unless file_reads.size > 1

  lastcols = []
  lastcols << "     #{lines_count_sum}" if options[:l]
  lastcols << "     #{words_count_sum}" if options[:w]
  lastcols << "    #{bytesize_sum}" if options[:c]
  lastcols << ' total'
  rows << lastcols.join
end

def build_rows(options, lines_count_sum, words_count_sum, bytesize_sum, file_reads)
  file_reads.map do |file, file_read|
    cols = []
    cols << (options[:l] ? "     #{file_read.lines.count.to_s.rjust(lines_count_sum.to_s.bytesize)}" : '')
    cols << (options[:w] ? "     #{file_read.split(/\s+/).size.to_s.rjust(words_count_sum.to_s.bytesize)}" : '')
    cols << (options[:c] ? "    #{file_read.size.to_s.rjust(bytesize_sum.to_s.bytesize)}" : '')
    cols << " #{file}"
    cols.join
  end
end

main
