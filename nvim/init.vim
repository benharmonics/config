" __          __   __                  __              
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

" Subsection: Plugin Options {{{

" https://github.com/luochen1990/rainbow
let g:rainbow_active=1

" }}} Plugin Options

" ===== The following subsection is required for coc.nvim ===== "

" Subsection: CoC {{{

" TextEdit might fail if hidden is not set
set hidden

" Some servers have issues with backup files
set nobackup nowritebackup

" Having longer updatetime (default is 4000ms) leads to
" noticable delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text
" each time diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" }}} CoC

" }}}

" Indentation Options ------------------------------------------------- {{{

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

" Status Options ------------------------------------------------------ {{{

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

" Functions And Macros ------------------------------------------------ {{{

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

" Subsection: CoC Mappings {{{

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0 )
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}} CoC Mappings

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

" Initial setup came from this site:
" https://www.stuartellis.name/articles/neovim-setup/
