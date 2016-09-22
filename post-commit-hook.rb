#!/usr/bin/env ruby

require 'cgi'
require 'git'

# Expectation is that this file resides in project/.git/hooks
root = File.expand_path(File.dirname(__FILE__)) + '/../../'
git = Git.open(root)
commit = git.log[0]
raw = commit.message.match(/^(.*)\{BLOG(.*?)\}\s*$/im)

# If they didn't use the BLOG 
# keyword then nothing to do 
exit 0 if raw.nil? 

# Look for extra parameters that should
# be put in the post front matter.
params = raw[2].empty? ? {} : CGI::parse(raw[2].strip)
params.each { |k, v| params[k] = v[0] if v.is_a?(Array) }

# Set the blog post body
body = raw[1].strip

# Attempt to separate a title from the body
parts = body.match(/^(.*?)(?:\r|\n|\r\n){2}(.*)$/m);

# If we can't separate a title from the body then just use the first 60 chars of the body
title = body[0...60].strip
if !parts.nil? && parts.length >= 3
    title = parts[1].strip
    body = parts[2].strip
end
filename = git.log[0].date.strftime("%Y-%m-%d") + '-' + title.downcase.gsub(' ', '-').gsub(/[^\w-]/, '') + '.md'

puts "Creating Jekyll file #{filename}"

# Add some default front matter fields.
# These can be overwritten by set values.
frontmatter = {
    "layout" => "post",
    "author" => "\"#{commit.author.name}\"",
    "title" => "\"#{title}\"",
    "date" => '"' + commit.date.strftime("%Y-%m-%d %H:%M:%S") + '"',
}.merge(params)

post = File.open(filename, 'w+')
post.puts('---')
frontmatter.each { |k, v| post.puts "#{k}: #{v}" }
post.puts('---')
post.puts('')
post.puts(body)

post.close