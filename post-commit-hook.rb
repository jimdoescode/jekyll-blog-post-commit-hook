#!/usr/bin/env ruby

require 'git'

g = Git.open('/Users/jim/Programs/jekyll-commit-blog')
matches = g.log[0].message.match(/^\[BLOG\](.*)/)
unless matches.nil? || matches.empty?
    puts matches[1];
    puts g.log[0].author.name
end
