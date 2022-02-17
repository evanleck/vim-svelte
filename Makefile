test: html5.vim vader.vim vim-javascript
	vim --nofork --clean -u test/vimrc -c 'Vader! test/*.vader'
.PHONY: test

vader.vim:
	git clone git@github.com:junegunn/vader.vim.git

vim-javascript:
	git clone git@github.com:pangloss/vim-javascript.git vim-javascript

html5.vim:
	git clone git@github.com:othree/html5.vim.git html5.vim

clean:
	rm -rf html5.vim vader.vim vim-javascript
.PHONY: clean
