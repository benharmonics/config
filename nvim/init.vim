"__          __   __                  __              
" |  \        |  \ |  \                |  \             
"  \▓▓_______  \▓▓_| ▓▓_      __     __ \▓▓______ ____  
" |  \       \|  \   ▓▓ \    |  \   /  \  \      \    \ 
" | ▓▓ ▓▓▓▓▓▓▓\ ▓▓\▓▓▓▓▓▓     \▓▓\ /  ▓▓ ▓▓ ▓▓▓▓▓▓\▓▓▓▓\
" | ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓ __     \▓▓\  ▓▓| ▓▓ ▓▓ | ▓▓ | ▓▓
" | ▓▓ ▓▓  | ▓▓ ▓▓ | ▓▓|  \__   \▓▓ ▓▓ | ▓▓ ▓▓ | ▓▓ | ▓▓
" | ▓▓ ▓▓  | ▓▓ ▓▓  \▓▓  ▓▓  \   \▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓
"  \▓▓\▓▓   \▓▓\▓▓   \▓▓▓▓ \▓▓    \▓    \▓▓\▓▓  \▓▓  \▓▓
                                                      
" Main Options -------------------------------------------------------- {{{

" Neovim doesn't set mapleader by default
let mapleader = ","

syntax on

" Relative line numbers except for current line
set number relativenumber

" Split sanity
set splitbelow splitright

" Highlight searches
set hlsearch

" Use case insensitive search, except when using capital letters
set ignorecase smartcase

" Stop certain movements from always going to the first character of a line.
" While this behavior deviates from that of Vi, it does what most users coming
" from other editors would expect
set nostartofline

" Display the cursor position on the last line of the screen
" or in the status line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you want to save changed files
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Set the command window height to 2 lines, to avoid many cases of
" having to 'press <Enter> to continue'
set cmdheight=2

" Don't wrap text
set nowrap

" Enable mouse support
set mouse=a

set encoding=utf-8

" }}}

" Plugins {{{

call plug#begin()

Plug 'luochen1990/rainbow'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

call plug#end()

" https://github.com/luochen1990/rainbow
let g:rainbow_active=1

" }}}

" Indentation ------------------------------------------------- {{{

" Indentation settings for using 4 spaces instead of tabs. Do not change
" 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4 softtabstop=4 expandtab smarttab

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, use
" the same indent as the line you're currently on. Useful for README files.
set autoindent

" VIM
autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2

" HTML, XML
autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType xml setlocal shiftwidth=2 tabstop=2 softtabstop=2

" Markdown, Journal
autocmd FileType markdown setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType journal setlocal shiftwidth=2 tabstop=2 softtabstop=2

" This will enable code folding using the marker method (as in this file).
augroup filetype_vim
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" Statusline ------------------------------------------------------ {{{

set statusline= " Clear status line when vimrc is reloaded

set statusline+=%n\ %F\     " buffer + file name
set statusline+=%h%m%r%w\   " flags
set statusline+=%Y          " filetype

set statusline+=%=          " rightalign

set statusline+=%10([%l,%3c]%)  " current line, column
set statusline+=\ %p%%          " percentage of file

" Always display the status line, even if only one window is displayed
set laststatus=2

" }}}

" Functions & Macros ------------------------------------------------ {{{

" Save & execute file
function Run()
  "  Rust
  if &filetype ==# 'rust' | !cargo run
  " Python
  elseif &filetype ==# 'python' | !python %
  " Shell
  elseif &filetype ==# 'bash' || &filetype ==# 'zsh' || &filetype ==# 'sh' || &filetype ==# 'fsh'
    !chmod +x %:p && %:p
  " C
  elseif &filetype ==# 'c' | !gcc % && ./a.out
  endif
endfunction

command R :w <bar> execute Run()

" Turn Mouse On/Off
function! ToggleMouse()
  " check if mouse is enabled
  if &mouse == 'a'
    " disable
    set mouse=
  else
    " enable mouse everywhere
    set mouse=a
  endif
endfunc

command Mouse execute ToggleMouse()

" We have a remapping that uses this function to mimic IDE behavior
function! JumpOver(char)
  " Jumps over a character if the cursor is already on it
  if getline(".")[col(".")-1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunction

" Subsection: Rust {{{

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

" Mappings ------------------------------------------------------------ {{{

" Map Y to act like D and C, i.e. to yank until EOL, rather than act exactly
" like yy, which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until next
" search
nnoremap <C-L> :nohl<CR><C-L>

" Closing brackets
inoremap [ []<left>
inoremap { {}<left>
inoremap ( ()<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
inoremap [<CR> [<CR>]<ESC>O
inoremap [;<CR> [<CR>];<ESC>O
inoremap (<CR> (<CR>)<ESC>O
inoremap (;<CR> (<CR>);<ESC>O

" Jump over closing bracket if cursor is already on it
inoremap <expr> } JumpOver('}')
inoremap <expr> ] JumpOver(']')
inoremap <expr> ) JumpOver(')')

" }}}

" Terminal Options ---------------------------------------------------- {{{

tmap <Esc> <C-\><C-n>           " go to 'normal' mode 
tmap <C-w> <Esc><C-w>           " enables c-w-w to change back to the other window
autocmd TermOpen * startinsert  " go to insert mode immediately
autocmd TermClose * :q          " don't show exit code, just close

" Have terminal open in a split pane rather than current window
command! -nargs=* T w | split | terminal <args>

" }}}

" Coda ---------------------------------------------------------------- {{{

" The following lines need to go at the end of your vimrc file

" ======================== Vim-Plug ======================== "
" Load all plugins now
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" }}}
