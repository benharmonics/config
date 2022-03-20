
"       (_)                   
" __   ___ _ __ ___  _ __ ___ 
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__ 
" (_)_/ |_|_| |_| |_|_|  \___|
                            
" NOTE: If you've never seen the section folding behavior in this .vimrc, you
" might be confused as to how to open and edit each section when using vim.

" In normal mode, `zo` unfolds each section and `zc` folds them again. The 
" folding behavior comes from the `augroup` function defined in the 
" PROGRAMMING MACROS section below.

" MAIN OPTIONS --------------------------------------------------------- {{{

" Set 'nocompatible' to ward off unexpected things that your distro might have
" made, as well as sanely reset options when resourcing .vimrc
set nocompatible

" Sets the line numbers, then changes all but the current line number to
" relative line numbers.
set number
set relativenumber

" Set splitting of the screen to priotitize splitting below & to the right
set splitbelow
set splitright

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Better command-line completion
set wildmenu

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, use
" the same indent as the line you're currently on. Useful for README files.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behavior deviates from that of Vi, it does what most users coming
" from other editors would expect
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you want to save changed files
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Set the command window height to 2 lines, to avoid many cases of having to
" 'press <Enter> to continue'
set cmdheight=2

" Don't wrap text
set nowrap

" Enable mouse support
set mouse=a

" }}}

" STATUS OPTIONS ----------------------------------------------------------- {{{

" Clear status line when vimrc is reloaded
set statusline=

set statusline+=%n\ %F\     " buffer + file name
set statusline+=%h%m%r%w\   " flags
set statusline+=%Y          " filetype

set statusline+=%=          " rightalign

set statusline+=%10([%l,%3c]%)  " current line, column
set statusline+=\ %p%%          " percentage of file

" Always display the status line, even if only one window is displayed
set laststatus=2

" }}}

" INDENTATION OPTIONS ------------------------------------------------------- {{{

" Indentation settings for using 4 spaces instead of tabs. Do not change
" 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" }}}

" MAPPINGS ------------------------------------------------------------------ {{{

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

" ALE mappings: see PLUGINS section

" }}}

" PROGRAMMING MACROS ------------------------------------------------------- {{{

function Run()
"  Rust - compile and run (cargo run)
  if &filetype ==# 'rust'
    !cargo run
  endif
" C - save, compile and run program
  if &filetype ==# 'c'
    :w
    !gcc % && ./a.out
  endif
" Python - save & run file
  if &filetype ==# 'python'
    :w
    !python %
  endif
endfunction

function Check()
"  Rust - check compiler (cargo check; this is faster than cargo run)
  if &filetype ==# 'rust'
    !cargo check
  endif
endfunction

function Test()
    " cargo test
    if &filetype ==# 'rust'
        !cargo test
    endif
endfunction


command R :w <bar> execute Run()

command C :w <bar> execute Check()

command T :w <bar> execute Test()

" }}}

" VIMSCRIPT ----------------------------------------------------------------- {{{

" This will enable code folding using the marker method (as in this file).
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" }}}

" PLUGINS ------------------------------------------------------------------- {{{

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetyupe
" and for plugins that are filetype specific.
" - not needed if using `call plug#end()` below
" filetype indent plugin on

" Enable syntax highlighting - not needed if using `call plug#end()` below
" syntax on

" Plugin Manager:

call plug#begin('~/.vim/plugged')

" https://github.com/junegunn/vim-plug
Plug 'rust-lang/rust.vim'

Plug 'frazrepo/vim-rainbow'

" https://github.com/dense-analysis/ale
Plug 'dense-analysis/ale'

" https://github.com/JuliaEditorSupport/julia-vim
Plug 'JuliaEditorSupport/julia-vim'

call plug#end()

" Rainbow brackets
let g:rainbow_active = 1

" Asynchronous Linting with ALE
let g:ale_linters = { 'rust': ['analyzer'], 'python': ['pylint'], }
let g:ale_fixers = { 'rust': ['rustfmt', 'trim_whitespace', 'remove_trailing_lines'] }

" ALE mappings
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" }}}

" FUNCTIONS ----------------------------------------------------------------- {{{

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

function! JumpOver(char)
    " Jumps over a character if the cursor is already on it
    if getline(".")[col(".")-1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" }}}

