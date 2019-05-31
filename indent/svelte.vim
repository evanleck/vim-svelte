" Vim indent file
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" URL:        https://github.com/evanleck/vim-svelte

if exists("b:did_indent")
  finish
endif

" All of the sub-language indentation logic is taken from
" https://github.com/posva/vim-vue, which seems to have handled this really
" nicely.
function! s:get_indentexpr(language)
  unlet! b:did_indent
  execute 'runtime! indent/' . a:language . '.vim'
  return &indentexpr
endfunction

" HTML is left out, it will be used when there is no match.
let s:languages = [
      \   { 'name': 'css', 'pairs': ['<style', '</style>'] },
      \   { 'name': 'javascript', 'pairs': ['<script', '</script>'] },
      \ ]

for s:language in s:languages
  " Set 'indentexpr' if the user has an indent file installed for the language
  if strlen(globpath(&rtp, 'indent/'. s:language.name .'.vim'))
    let s:language.indentexpr = s:get_indentexpr(s:language.name)
  endif
endfor

let s:html_indent = s:get_indentexpr('html')
let b:did_indent = 1

setlocal indentexpr=GetSvelteIndent()
setlocal indentkeys=o,O,*<Return>,<>>,{,},0),0],!^F,=:else,=:then,=:catch,=/if,=/each,=/await

" Only define the function once.
if exists('*GetSvelteIndent')
  finish
endif

function! GetSvelteIndent()
  for language in s:languages
    let opening_tag_line = searchpair(language.pairs[0], '', language.pairs[1], 'bWr')

    if opening_tag_line
      execute 'let indent = ' . get(language, 'indentexpr', -1)
      break
    endif
  endfor

  " Only evaluate if we didn't match a <script> or <style> block above.
  if !exists('l:indent')
    let line_number = v:lnum

    if line_number == 0
      return 0
    endif

    let sw = shiftwidth()

    let current_line = getline(line_number)
    let previous_line_number = prevnonblank(line_number - 1)
    let previous_line = getline(previous_line_number)

    execute "let indent = " . s:html_indent

    " Previous line like "#if" or "#each"
    if previous_line =~ '^\s*{\s*#\(if\|each\|await\)'
      let indent = indent + sw
    endif

    " Previous line like ":else" or ":then"
    if previous_line =~ '^\s*{\s*:\(else\|catch\|then\)'
      let indent = indent + sw
    endif

    " Previous line looks like an HTML element but the current line hasn't been
    " indented.
    if synID(previous_line_number, match(previous_line, '\S') + 1, 0) == hlID('htmlTag') && indent == indent(previous_line_number)
      let indent = indent + sw
    endif

    " Current line like ":else" or ":then"
    if current_line =~ '^\s*{\s*:\(else\|catch\|then\)'
      let indent = indent - sw
    endif

    if current_line =~ '^\s*{\s*\/\(await\|if\|each\)'
      let indent = indent - sw
    endif
  endif

  return indent
endfunction
