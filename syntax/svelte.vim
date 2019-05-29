" Vim syntax file
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" Depends:    pangloss/vim-javascript
" URL:        https://github.com/evanleck/vim-svelte
"
" Like vim-jsx, this depends on the pangloss/vim-javascript syntax package (and
" is tested against it exclusively). If you're using vim-polyglot (like I am),
" then you're all set.

if exists("b:current_syntax")
  finish
endif

" Read HTML to begin with.
runtime! syntax/html.vim
unlet! b:current_syntax

" Expand HTML tag names to include mixed case, periods, and colons.
syntax match htmlTagName contained "\<[a-zA-Z:\.]*\>"

" Special attributes that include some kind of binding e.g. "on:click",
" "bind:something", etc.
syntax match svelteKeyword "\<[a-z]\+:[a-z|]\+=" contained containedin=htmlTag

" The "slot" attribute has special meaning.
syntax keyword svelteKeyword slot contained containedin=htmlTag

" According to vim-jsx, you can let jsBlock take care of ending the region.
"   https://github.com/mxw/vim-jsx/blob/master/after/syntax/jsx.vim
syntax region svelteExpression start="{" end="" contains=jsBlock,javascriptBlock containedin=ALLBUT,jsBlock,javascriptBlock

" Block conditionals.
syntax match svelteConditional "#if" contained containedin=jsBlock,javascriptBlock
syntax match svelteConditional "/if" contained containedin=jsBlock,javascriptBlock
syntax match svelteConditional ":else if" contained containedin=jsBlock,javascriptBlock
syntax match svelteConditional ":else" contained containedin=jsBlock,javascriptBlock

" Block keywords.
syntax match svelteKeyword "#await" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword "/await" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword ":catch" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword ":then" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword "@html" contained containedin=jsBlock,javascriptBlock

" Repeat functions.
syntax match svelteRepeat "#each" contained containedin=jsBlock,javascriptBlock
syntax match svelteRepeat "/each" contained containedin=jsBlock,javascriptBlock

highlight def link svelteConditional Conditional
highlight def link svelteKeyword Keyword
highlight def link svelteRepeat Repeat

let b:current_syntax = "svelte"
