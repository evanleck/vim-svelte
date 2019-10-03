.PHONY: test

test: vader.vim
	vim --nofork --clean -u test/vimrc -c 'Vader! test/*.vader'

vader.vim:
	git clone https://github.com/junegunn/vader.vim.git
