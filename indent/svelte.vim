" Vim indent file
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" URL:        https://github.com/evanleck/vim-svelte

if exists("b:did_indent")
  finish
endif

runtime! indent/html.vim
unlet! b:did_indent

" Force HTML indent to not keep state.
let b:html_indent_usestate = 0

" Inspired by/lifted from eruby.vim.
if &l:indentexpr == ''
  if &l:cindent
    let &l:indentexpr = 'cindent(v:lnum)'
  else
    let &l:indentexpr = 'indent(prevnonblank(v:lnum-1))'
  endif
endif
let b:svelte_subtype_indentexpr = &l:indentexpr

let b:did_indent = 1

setlocal indentexpr=GetSvelteIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],!^F

" Only define the function once.
if exists('*GetSvelteIndent')
  finish
endif

function! GetSvelteIndent()
  let line_number = v:lnum

  if line_number == 0
    return 0
  endif

  let sw = shiftwidth()

  let current_line = getline(line_number)
  let previous_line_number = prevnonblank(line_number - 1)
  let previous_line = getline(previous_line_number)

  exe "let indent = ".b:svelte_subtype_indentexpr

  if previous_line =~ '^\s*{\s*#\(if\|each\|await\)'
    let indent = indent + sw
  endif

  if current_line =~ '^\s*{\s*:\(else\|catch\|then\)'
    let indent = indent - sw
  endif

  if current_line =~ '^\s*{\s*\/\(await\|if\|each\)'
    let indent = indent - sw
  endif

  return indent
endfunction
