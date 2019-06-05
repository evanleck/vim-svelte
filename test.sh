#!/bin/sh
vim -c "set shiftwidth=2 expandtab | execute 'normal! gg=G' | update | quitall" test/indent.svelte

if git diff --exit-code test/indent.svelte; then
  echo "Indentation looks good."
else
  echo "Indentation in test/indent.svelte has changed; please review the diff below and update indent/svelte.vim. test/indent.svelte will be reverted."

  git diff test/indent.svelte
  git checkout HEAD -- test/indent.svelte
fi
