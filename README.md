Jekyll Blog Post Commit Hook
----------------------------

A git post commit hook that will create a Jekyll markdown file based off a git commit message.

Installation
------------

Download the source and run:
```sh
$ make install
```

This will make sure that the necessary gems are installed and then will prompt you for the location of the project you want to use the hook with. It then copies the hook to the `.git/hooks` directory of that project.

Usage
-----

Once you have the hook installed you can make commits as you would normally and any commit message that **ends** with `{BLOG}` will have a markdown file generated for it in the project directory. You can optionally add front matter to your posts by specifying it in the blog tag like this `{BLOG tags=[foo, bar]&layout=test}`.

I hope you have some fun with this!
