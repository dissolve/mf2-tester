#!/usr/bin/env ruby

require 'microformats'
require 'json'

def print_usage
  puts 'Usage: microformats (URL, filepath, or HTML)'
end

def process_html(html)
    collection = Microformats.parse(html, base: 'http://example.com/')
  puts JSON.pretty_generate(JSON[collection.to_json.to_s])
end

if STDIN.tty?
  if ARGV[0].nil?
    print_usage
  else
    process_html(ARGV[0])
  end
else
  html = STDIN.read

  if html.nil?
    print_usage
  else
    process_html(html)
  end
end
