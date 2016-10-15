Gem::Specification.new do |s|
    s.name = 'jekyll-commit-blog'
    s.version = '1.0.0'
    s.executables << 'jekyll-post-commit'
    s.summary = "Format git commit messages into Jekyll markdown blog posts."
    s.description = "A simple command for generating Jekyll blog posts from git commit messages. It can be run directly from the command line or installed as a post-commit hook."
    s.authors = ["Jim Saunders"]
    s.email = "jimdoescode@gmail.com"
    s.license = "MIT"
    s.homepage = 'https://github.com/jimdoescode/jekyll-commit-blog'
    s.required_ruby_version = '>= 2.2.0'
    s.add_runtime_dependency "git",
    [">= 1.3.0"]
end
