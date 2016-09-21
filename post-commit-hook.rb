#!/usr/bin/env ruby

require 'cgi'
require 'git'

git = Git.open('/Users/jim/Programs/jekyll-commit-blog')
raw = git.log[0].message.match(/^\{BLOG(.*)\}(.*)$/im)

# If they didn't use the BLOG 
# keyword then nothing to do 
exit 0 if raw.nil? 

# Look for extra parameters that should
# be put in the post front matter.
params = raw[1].empty? ? {} : CGI::parse(raw[1].strip)
params.each { |k, v| params[k] = v[0] if v.is_a?(Array) }

# Set the blog post body
body = raw[2].strip

# Attempt to separate a title from the body
parts = body.match(/^(.*)(?:\r|\n|\r\n){2}(.*)$/m);

# If we can't separate a title from the body then just use the first 60 chars of the body
title = (parts.nil? || parts.length < 3) ? body[0...60].strip : parts[1].strip 
slug = git.log[0].date.strftime("%Y-%m-%d") + '-' + title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

# Add some default front matter fields.
# These can be overwritten by set values.
frontmatter = {
    "layout" => "post",
    "author" => git.log[0].author.name,
    "title" => "\"#{title}\"",
    "date" => git.log[0].date.strftime("%Y-%m-%d %H:%M:%S"),
}.merge(params)

post = File.open(slug + '.md', 'w+')
post.puts('---')
frontmatter.each { |k, v| post.puts "#{k}: #{v}" }
post.puts('---')
post.puts('')
post.puts(body)

post.close