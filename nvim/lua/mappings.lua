-- Helper functions
local function map(mode, shortcut, command, opts)
  vim.api.nvim_set_keymap(mode, shortcut, command, opts or { noremap = true, silent = true })
end
local function nmap(shortcut, command, opts) map('n', shortcut, command, opts) end
local function imap(shortcut, command, opts) map('i', shortcut, command, opts) end
local function tmap(shortcut, command, opts) map('t', shortcut, command, opts) end

-- Map Y to act like D and C, i.e. to yank until EOL, rather than act exactly like yy, which is the default
nmap('Y', 'y$', { noremap = false, silent = true })

-- Map <C-L> (redraw screen) to also turn off search highlighting until next search
nmap('<c-l>', ':nohl<cr><c-l>')

-- Easily resize window
nmap('<leader>+', '<c-w>+')
nmap('<leader>-', '<c-w>-')
nmap('<leader>>', '<c-w>>')
nmap('<leader><', '<c-w><')

-- Easily swap between open windows
nmap('<leader>h', '<c-w>h')
nmap('<leader>l', '<c-w>l')
nmap('<leader>j', '<c-w>j')
nmap('<leader>k', '<c-w>k')

-- Closing brackets
imap('{', '{}<left>')
imap('[', '[]<left>')
imap('(', '()<left>')
imap('{<cr>', '{<cr>}<esc>O')
imap('{;<cr>', '{<cr>};<esc>O')
imap('[<cr>', '[<cr>]<esc>O')
imap('[;<cr>', '[<cr>];<esc>O')
imap('(;<cr>', '(<cr>);<esc>O')

-- jump_over jumps over closing brackets if you type the bracket char
local function jump_over(char)
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local char_on_cursor = vim.api.nvim_get_current_line():sub(col + 1, col + 1)
  if char_on_cursor == char
  then
    return '<right>'
  else
    return char
  end
end

vim.keymap.set('i', ')', function() return jump_over(')') end, { expr = true })
vim.keymap.set('i', ']', function() return jump_over(']') end, { expr = true })
vim.keymap.set('i', '}', function() return jump_over('}') end, { expr = true })

-- NERDTree
nmap('<leader>n', ':NERDTreeFocus<cr>')
nmap('<leader>t', ':NERDTreeToggle<cr>')
nmap('<c-f>t', ':NERDTreeFind<cr>')

-- Terminal
tmap('<esc>', '<c-\\><c-n>') -- go to normal mode in terminal mode
tmap('<c-w>', '<esc><c-w>')  -- enables C-w-w to change back to other window
