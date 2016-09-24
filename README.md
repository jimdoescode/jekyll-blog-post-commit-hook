Jekyll Commit Blog
------------------

A command that will create a Jekyll markdown file based off a git commit message. The command can optionally be installed as a commit hook.

It looks for a commit message that **ends** with `{BLOG}` and generates a Jekyll post file for it in the current directory. You can optionally add front matter to your posts by specifying it in the blog tag like this `{BLOG tags=[foo, bar]&layout=test}`.

Usage
-----

You can run the command in the current directory for the latest commit like this
```sh
$ post-commit
```

If you'd rather run the command in another project then you can specify the project directory as the first arguement
```sh
$ post-commit /path/to/project
```

You can also specify a second parameter which indicates a specific commit. You can either use the full or partial commit hash or the HEAD offset.
```sh
$ post-commit /path/to/project HEAD~
$ post-commit /path/to/project 123abc
```
*NOTE:* If you specify a commit then a Jekyll file will be generated regardless of if a `{BLOG}` tag is at the end of the commit message.

Installation as a commit hook
-----------------------------

You can install this command as a git post-commit hook (a hook that's run after a commit). Simply use the included Makefile:
```sh
$ make install-hook
```

This will make sure that the necessary gems are installed and then prompts you for the location of the project you want to use the hook with. It then copies the hook to the `<project>/.git/hooks` directory.
