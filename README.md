# vim-svelte

Vim syntax highlighting and indentation for [Svelte 3][svelte] components.

This is mostly just HTML syntax highlighting with some keywords added and all
expressions inside of `{` and `}` highlighted as JavaScript.

Highlighting includes:

- HTML attributes with a colon like `on:click` or `transition:fade` highlighted
    as `Keyword`.
- `#if`, `/if`, `:else`, and `:else if` highlighted as `Conditional`.
- `#await`, `/await`, `:catch`, `:then`, and `@html` highlighted as `Keyword`.
- `#each` and `/each` highlighted as `Repeat`.


## Dependencies

The JavaScript highlighting depends on
[pangloss/vim-javascript][vim-javascript]. That ships with
[sheerun/vim-polyglot][vim-polyglot] so if you're already using that then you
should be set.


## Installation

The simplest way to install vim-svelte is via a package manager like
[Pathogen][pathogen], [Vundle][vundle], [NeoBundle][neobundle],
[Plug][vim-plug], or [minpac][minpac].

For example, using minpac:

```vimscript
call minpac#add('evanleck/vim-svelte')
```

Or using Plug:

```vimscript
Plug 'evanleck/vim-svelte'
```

vim-svelte works just fine with Vim 8's native package loading as well, that's
what I use.


## Options

To disable indentation within `<script>` and `<style>` tags, set one of these
variables in your `vimrc`:

```vim
let g:svelte_indent_script = 0
let g:svelte_indent_style = 0
```


## Integrations

- [ALE][ale]: vim-svelte should work out of the box with `eslint` and a few
  other linters/fixers. PRs welcome if the one you want is missing.
- [matchit.vim][matchit]: vim-svelte should work out of the box and allow moving
  between HTML tags as well as flow control like `#if/:else//if`.


## Tests

Indentation tests are provided and any contributions would be much appreciated.
They can be run with `make test` which will clone [vader.vim][vader] into the
current working directory and run the test suite.


## Alternatives

1. [burner/vim-svelte][burner]
2. [leafOfTree/vim-svelte-plugin][leafOfTree]


[ale]: https://github.com/dense-analysis/ale
[burner]: https://github.com/burner/vim-svelte
[leafOfTree]: https://github.com/leafOfTree/vim-svelte-plugin
[matchit]: https://github.com/adelarsq/vim-matchit
[minpac]: https://github.com/k-takata/minpac
[neobundle]: https://github.com/Shougo/neobundle.vim
[pathogen]: https://github.com/tpope/vim-pathogen
[svelte]: https://svelte.dev
[vader]: https://github.com/junegunn/vader.vim
[vim-javascript]: https://github.com/pangloss/vim-javascript
[vim-plug]: https://github.com/junegunn/vim-plug
[vim-polyglot]: https://github.com/sheerun/vim-polyglot
[vundle]: https://github.com/VundleVim/Vundle.vim
