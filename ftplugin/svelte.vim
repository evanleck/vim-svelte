" Vim filetype plugin
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" URL:        https://github.com/evanleck/vim-svelte
if (exists('b:did_ftplugin'))
  finish
endif
let b:did_ftplugin = 1

" Matchit support
if exists('loaded_matchit') && !exists('b:match_words')
  let b:match_ignorecase = 0

  "
  " In order:
  "
  " 1. Parens.
  " 2, 3, 4. HTML tags pulled from Vim itself.
  " 5. Svelte control flow keywords.
  "
  " https://github.com/vim/vim/blob/5259275347667a90fb88d8ea74331f88ad68edfc/runtime/ftplugin/html.vim#L29-L35
  "
  let b:match_words =
        \ '<:>,{:},' .
        \ '<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,' .
        \ '<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,' .
        \ '<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>,' .
        \ '\<#\(if\|await\|each\)\>:\<\:\(else\|catch\|then\)\>:\<\/\(if\|await\|each\)\>'
endif
