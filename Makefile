test: vader.vim vim-javascript
	vim --nofork --clean -u test/vimrc -c 'Vader! test/*.vader'
.PHONY: test

vader.vim:
	git clone https://github.com/junegunn/vader.vim.git

vim-javascript:
	git clone https://github.com/pangloss/vim-javascript.git vim-javascript

clean:
	rm -rf vim-javascript vader.vim
.PHONY: clean
