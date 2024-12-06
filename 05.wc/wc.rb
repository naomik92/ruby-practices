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

  puts "#{build_count(options, contents).join("\n")}"
end

def build_count(options, contents)
  counts = count_contents(contents)
  lines_count_sum = counts.sum { |h| h[:lines] }
  words_count_sum = counts.sum { |h| h[:words] }
  chars_count_sum = counts.sum { |h| h[:chars] }
  col_width = [lines_count_sum, words_count_sum, chars_count_sum].max.to_s.bytesize

  rows = build_rows(options, counts, col_width)

  return rows if contents.size <= 1

  lastcols = []
  lastcols << "    #{lines_count_sum.to_s.rjust(col_width)}" if options[:l]
  lastcols << "    #{words_count_sum.to_s.rjust(col_width)}" if options[:w]
  lastcols << "    #{chars_count_sum.to_s.rjust(col_width)}" if options[:c]
  lastcols << ' total'
  rows << lastcols.join
end

def build_rows(options, counts, col_width = 0)
  counts.map do |count|
    cols = []
    cols << "    #{count[:lines].to_s.rjust(col_width)}" if options[:l]
    cols << "    #{count[:words].to_s.rjust(col_width)}" if options[:w]
    cols << "    #{count[:chars].to_s.rjust(col_width)}" if options[:c]
    cols << " #{count[:filename]}"
    cols.join
  end
end

def count_contents(contents)
  contents.map do |file_name, file_content|
    {
      filename: file_name,
      lines: file_content.lines.count,
      words: file_content.split(/.\s+/).size,
      chars: file_content.size
    }
  end
end

main
