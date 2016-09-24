hook_file := post-commit

.PHONY: $(hook_file) install-dependencies install-hook
install-hook: check-dependencies $(hook_file)

check-dependencies:
	@gem install git
    
$(hook_file): check-dependencies
	@read -p "Enter the full path to your project directory: " dir; \
	hook_dir=$$dir/.git/hooks; \
	cp -f $@ $$hook_dir/post-commit; \
	echo "Installed post-commit hook to $$hook_dir"

