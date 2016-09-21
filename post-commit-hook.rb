#!/usr/bin/env ruby

require 'git'

g = Git.open('/Users/jim/Programs/jekyll-commit-blog')
puts g.log[0].message
puts g.log[0].author.name