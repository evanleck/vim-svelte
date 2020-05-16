" Vim syntax file
" Language:   Svelte 3 (HTML/JavaScript)
" Author:     Evan Lecklider <evan@lecklider.com>
" Maintainer: Evan Lecklide <evan@lecklider.com>
" Depends:    pangloss/vim-javascript
" URL:        https://github.com/evanleck/vim-svelte
"
" Like vim-jsx, this depends on the pangloss/vim-javascript syntax package (and
" is tested against it exclusively). If you're using vim-polyglot, then you're
" all set.

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
syntax match svelteKeyword "\<[a-z]\+:[a-zA-Z|]\+=" contained containedin=htmlTag

" Mixed-case attributes are likely props.
syntax match svelteKeyword "\<[a-z]\+:[a-zA-Z|]\+=" contained containedin=htmlTag

" The "slot" attribute has special meaning.
syntax keyword svelteKeyword slot contained containedin=htmlTag

" According to vim-jsx, you can let jsBlock take care of ending the region.
"   https://github.com/mxw/vim-jsx/blob/master/after/syntax/jsx.vim
syntax region svelteExpression start="{" end="" contains=jsBlock,javascriptBlock containedin=htmlString,htmlTag,htmlArg,htmlValue,htmlH1,htmlH2,htmlH3,htmlH4,htmlH5,htmlH6,htmlHead,htmlTitle,htmlBoldItalicUnderline,htmlUnderlineBold,htmlUnderlineItalicBold,htmlUnderlineBoldItalic,htmlItalicUnderline,htmlItalicBold,htmlItalicBoldUnderline,htmlItalicUnderlineBold,htmlLink,htmlLeadingSpace,htmlBold,htmlBoldUnderline,htmlBoldItalic,htmlBoldUnderlineItalic,htmlUnderline,htmlUnderlineItalic,htmlItalic,htmlStrike,javaScript

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

" Inline keywords.
syntax match svelteKeyword "@html" contained containedin=jsBlock,javascriptBlock
syntax match svelteKeyword "@debug" contained containedin=jsBlock,javascriptBlock

" Repeat functions.
syntax match svelteRepeat "#each" contained containedin=jsBlock,javascriptBlock
syntax match svelteRepeat "/each" contained containedin=jsBlock,javascriptBlock

highlight def link svelteConditional Conditional
highlight def link svelteKeyword Keyword
highlight def link svelteRepeat Repeat

" Taken from vim-vue
" Get the pattern for a HTML {name} attribute with {value}.
function! s:attr(name, value)
  return a:name . '=\("\|''\)[^\1]*' . a:value . '[^\1]*\1'
endfunction

function! s:should_register(language, start_pattern)
  " Check whether a syntax file for {language} exists
  if empty(globpath(&runtimepath, 'syntax/' . a:language . '.vim'))
    return 0
  endif

  if exists('g:svelte_pre_processors')
    if type(g:svelte_pre_processors) == v:t_list
      return index(g:svelte_pre_processors, s:language.name) != -1
    elseif g:svelte_pre_processors is# 'detect_on_enter'
      return search(a:start_pattern, 'n') != 0
    endif
  endif

  return 1
endfunction

let s:languages = [
      \ {'name': 'typescript', 'tag': 'script', 'attr_pattern': '\%(lang=\("\|''\)[^\1]*\(ts\|typescript\)[^\1]*\1\|ts\)'},
      \ ]

for s:language in s:languages
  let s:attr_pattern = has_key(s:language, 'attr_pattern') ? s:language.attr_pattern : s:attr('lang', s:language.name)
  let s:start_pattern = '<' . s:language.tag . '\>\_[^>]*' . s:attr_pattern . '\_[^>]*>'

  if s:should_register(s:language.name, s:start_pattern)
    execute 'syntax include @' . s:language.name . ' syntax/' . s:language.name . '.vim'
    unlet! b:current_syntax
    execute 'syntax region svelte_' . s:language.name
          \ 'keepend'
          \ 'start=/' . s:start_pattern . '/'
          \ 'end="</' . s:language.tag . '>"me=s-1'
          \ 'contains=@' . s:language.name . ',svelteSurroundingTag'
          \ 'fold'
  endif
endfor

syn region svelteSurroundingTag contained start=+<\(script\|style\|template\)+ end=+>+ fold contains=htmlTagN,htmlString,htmlArg,htmlValue,htmlTagError,htmlEvent
syn keyword htmlSpecialTagName contained template
syn keyword htmlArg contained scoped ts
syn match htmlArg "[@v:][-:.0-9_a-z]*\>" contained

let b:current_syntax = "svelte"
