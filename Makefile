hook_file := post-commit-hook.rb

.PHONY: $(hook_file) gem-install install
install: gem-install $(hook_file)

gem-install:
	@gem install git
    
$(hook_file): gem-install
	@read -p "Enter the full path to your project directory: " dir; \
	hook_dir=$$dir/.git/hooks; \
	cp -f $@ $$hook_dir/post-commit; \
	echo "Installed post-commit hook to $$hook_dir"

