#!/bin/ruby
require 'pp'

# youtube-dl doesn't really download things the way I'd like.
# The names have a tonne of metadata and aren't readeable.
# Yes, this could all be done in a line of Fish/Bash with sed. 
# But I needed a ruby example.

directory = $ARGV[0]
files = Dir.entries(directory).filter { |x| x.include? 'mp3' }
files.each do |file|

  # getting rid of everything except the song name.
  name = file.reverse.split('.', 2)[1][12..].split('-')[0].reverse

  # some songs also have garbage in brackets, also dont like commas, periods, or single quotes in names.
  name.gsub!(/\(.*\)/, '')
  name.gsub!(/\[.*\]/, '')
  name.gsub!(/\.|\,|\'/, '')

  # Some song names have metadata seperated by underscores. and emdashes??
  name = name.split('_')[-1].split('—')[-1].strip.split(' ').join('-')

  File.rename("#{directory}/#{file}", "#{directory}/#{name}.mp3")
end
