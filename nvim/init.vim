"__          __   __                  __
" |  \        |  \ |  \                |  \
"  \▓▓_______  \▓▓_| ▓▓_      __     __ \▓▓______ ____
" |  \       \|  \   ▓▓ \    |  \   /  \  \      \    \
" | ▓▓ ▓▓▓▓▓▓▓\ ▓▓\▓▓▓▓▓▓     \▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\
" | ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ __     \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓
" | ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓|  \__   \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓
" | ▓▓ ▓▓  | ▓▓ ▓▓  \▓▓  ▓▓  \   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓
"  \▓▓\▓▓   \▓▓\▓▓   \▓▓▓▓ \▓▓    \▓    \▓▓\▓▓  \▓▓  \▓▓

lua require('init')

" Functions & Macros ------------------------------------------------ {{{

" Save & execute file
function Run()
  "  Rust
  if &filetype ==# 'rust' | !cargo run
  " Python
  elseif &filetype ==# 'python' | !python %
  " C
  elseif &filetype ==# 'c' | !gcc % && ./a.out
  " JavaScript
  elseif &filetype ==# 'javascript' | !node .
  " Shell
  elseif &filetype ==# 'bash' || &filetype ==# 'zsh' || &filetype ==# 'sh' || &filetype ==# 'fsh'
    !chmod +x %:p && %:p
  endif
endfunction

command R :w <bar> execute Run()

" Turn Mouse On/Off
function! ToggleMouse()
  if &mouse == 'a' " check if mouse is enabled
    set mouse=
  else
    set mouse=a
  endif
endfunc

command Mouse execute ToggleMouse()

" pad line with filler character to a given length
function! PaddedComment(length = 70, fill = "-")
  let line = getline('.')
  " the regex removes comment delimiters, i.e. // or # or "
  let comment = substitute(line, '^["\|\#\|\/]*', '', '')
  let comment_i = stridx(line, comment)
  " collect the comment delimiters
  let prelude = line[:comment_i - 1]
  let start_width = col('$') - 1
  " pad evenly on both sides of comment to given length
  let padsize = (a:length - start_width - comment_i) / 2
  if padsize < 0
    let padsize = 0
  endif
  let pad = repeat(a:fill, padsize)
  " trim whitespace from collected comment
  let trimmed_comment = substitute(substitute(comment, '^  *', '', ''), '  *$', '', '')
  let new_line = prelude .. ' ' .. pad  .. ' ' .. trimmed_comment .. ' ' .. pad
  " replace every character in current line with new line
  .s/.*/\=new_line/
endfunc

command! -nargs=? Pad :call PaddedComment(<f-args>)

" Subsection: Rust ---------------------------------------------------- {{{

" cargo check
function Check()
  if &filetype ==# 'rust'
    !cargo check
  endif
endfunction

" cargo test
function Test()
  if &filetype ==# 'rust'
    !cargo test
  endif
endfunction

" cargo fmt
function Fmt()
  if &filetype ==# 'rust'
    !cargo fmt
  endif
endfunction

" cargo clippy
function Clippy()
  if &filetype ==# 'rust'
    !cargo clippy
  endif
endfunction

command Check :w <bar> execute Check()
command Test :w <bar> execute Test()
command Fmt :w <bar> execute Fmt()
command Clippy :w <bar> execute Clippy()

" }}} Rust

" }}}

" Terminal Options ---------------------------------------------------- {{{

" Have terminal open in a split pane rather than current window
command! -nargs=* T w | split | terminal <args>

" }}} \Terminal Options

" Coda ---------------------------------------------------------------- {{{

" The following lines need to go at the end of your init.vim file

" ------------------------ Vim-Plug ------------------------
" Load all plugins now
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" }}}
