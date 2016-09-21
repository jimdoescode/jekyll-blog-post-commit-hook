#!/usr/bin/env ruby

require 'git'

git = Git.open('/Users/jim/Programs/jekyll-commit-blog')
raw = git.log[0].message.match(/^\[BLOG\](.*)/m)
author = git.log[0].author.name
datetime = git.log[0].date.strftime("%Y-%m-%d %H:%M:%S")

# If they didn't use the BLOG 
# keyword then nothing to do 
exit 0 if raw.nil? 

# Set the blog post body
body = raw[1].strip

# Attempt to separate a title from the body
parts = body.match(/^(.*)(?:\r|\n|\r\n){2}(.*)$/);

# If we can't separate a title from the body then just use the first 60 chars of the body
title = (parts.nil? || parts.length < 3) ? body[0...60].strip : parts[1].strip 
slug = git.log[0].date.strftime("%Y-%m-%d") + '-' + title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

post = File.open(slug + '.md', 'w+')
post.puts('---')
post.puts('layout: post')
post.puts('author: ' + author)
post.puts('title:  "' + title + '"')
post.puts('date:   ' + datetime)
post.puts('---')
post.puts('')
post.puts(body)

post.close