#!/usr/bin/env ruby

require 'git'

git = Git.open('/Users/jim/Programs/jekyll-commit-blog')
raw = git.log[0].message.match(/^\{BLOG(.*)\}(.*)$/im)

# If they didn't use the BLOG 
# keyword then nothing to do 
exit 0 if raw.nil? 

params = raw[1].empty? {} : CGI::parse(raw[1].strip)
# Set the blog post body
body = raw[2].strip

# Attempt to separate a title from the body
parts = body.match(/^(.*)(?:\r|\n|\r\n){2}(.*)$/m);

# If we can't separate a title from the body then just use the first 60 chars of the body
title = (parts.nil? || parts.length < 3) ? body[0...60].strip : parts[1].strip 
slug = git.log[0].date.strftime("%Y-%m-%d") + '-' + title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')

frontmatter = {
    "layout" => "post",
    "author" => git.log[0].author.name,
    "title" => "\"#{title}\"",
    "date" => git.log[0].date.strftime("%Y-%m-%d %H:%M:%S"),
}.merge(params)

post = File.open(slug + '.md', 'w+')
# Add the front matter
post.puts('---')
frontmatter.each { |key, value|
    puts "#{key}: #{value}"
}
post.puts('---')
post.puts('')
post.puts(body)

post.close