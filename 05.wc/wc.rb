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

  print "#{build_count(options, contents).join("\n")}\n"
end

def build_count(options, contents)
  counts = count_contents(contents)
  col_width = [counts[:lines].sum, counts[:words].sum, counts[:chars].sum].max.to_s.bytesize

  rows = build_rows(options, counts, col_width)

  return rows unless contents.size > 1

  lastcols = []
  lastcols << "    #{counts[:lines].sum.to_s.rjust(col_width)}" if options[:l]
  lastcols << "    #{counts[:words].sum.to_s.rjust(col_width)}" if options[:w]
  lastcols << "    #{counts[:chars].sum.to_s.rjust(col_width)}" if options[:c]
  lastcols << ' total'
  rows << lastcols.join
end

def build_rows(options, counts, col_width = 0)
  (0..counts[:lines].size - 1).map do |x|
    cols = []
    cols << "    #{counts[:lines][x].to_s.rjust(col_width)}" if options[:l]
    cols << "    #{counts[:words][x].to_s.rjust(col_width)}" if options[:w]
    cols << "    #{counts[:chars][x].to_s.rjust(col_width)}" if options[:c]
    cols << " #{counts[:files][x]}"
    cols.join
  end
end

def count_contents(contents)
  {
    lines: contents.values.map { |value| value.lines.count },
    words: contents.values.map { |value| value.split(/.\s+/).size },
    chars: contents.values.map(&:size),
    files: contents.keys
  }
end

main
