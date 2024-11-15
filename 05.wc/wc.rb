#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  files = ARGV
  display_count(files)
end

def display_count(files)
  file_reads = files.to_h { |file| [file, File.read(file)] }
  # files.each do |file|
  #   file_read = File.read(file)
  #   puts build_all_count(file, file_read)
  # end
  print build_all_count(files, file_reads).join("\n")
end

def build_all_count(files, file_reads)
  lines_count_sum = file_reads.values.map { |value| value.lines.count }.sum
  words_count_sum = file_reads.values.map { |value| value.split(/\s+/).size }.sum
  bytesize_sum = file_reads.values.map { |value| value.size }.sum

  rows = file_reads.map do |file, file_read|
    cols = []
    cols << "     #{file_read.lines.count.to_s.rjust(lines_count_sum.to_s.bytesize)}"
    cols << "     #{file_read.split(/\s+/).size.to_s.rjust(words_count_sum.to_s.bytesize)}"
    cols << "    #{file_read.size.to_s.rjust(bytesize_sum.to_s.bytesize)}"
    cols << " #{file}"
    cols.join
  end

  lastcols = []
  lastcols << "     #{lines_count_sum}"
  lastcols << "     #{words_count_sum}"
  lastcols << "    #{bytesize_sum}"
  lastcols << " total"
  rows << lastcols.join
end

main
