.PHONY: test

test:
	vim --nofork --clean -u test/vimrc -c 'Vader! test/*.vader'
