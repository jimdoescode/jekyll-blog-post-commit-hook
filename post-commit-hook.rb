#!/usr/bin/env ruby

require 'git'

g = Git.open('/Users/jim/Programs/jekyll-commit-blog', :log => Logger.new(STDOUT))
g.log.each { |l| puts l.author.name }