#!/bin/sh
vim -c "execute 'normal! gg=G' | update | quitall" ./Test.svelte
git diff ./Test.svelte
