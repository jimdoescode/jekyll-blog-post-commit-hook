#!/usr/bin/env ruby

require 'git'
require 'logger'

puts 'TEST'
g = Git.open('/Users/jim/Programs/jekyll-commit-blog')
g.log.each { |l| puts l.author.name }