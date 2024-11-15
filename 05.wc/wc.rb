#!/usr/bin/env ruby
# frozen_string_literal: true

def main
  files = ARGV
  display_count(files)
end

def display_count(files)
  files.each do |file|
    file_read = File.read(file)
    puts build_all_count(file, file_read)
  end
end

def build_all_count(file, file_read)
  cols = []
  cols << "#{file_read.lines.count}"
  cols << " #{file_read.split(/\s+/).size}"
  cols << " #{file_read.size}"
  cols << " #{file}"
  cols.join
end

main
