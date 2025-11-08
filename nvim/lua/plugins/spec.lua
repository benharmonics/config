local function nmap(shortcut, command, opts)
  vim.keymap.set('n', shortcut, command, opts)
end

return {
  { 'neovim/nvim-lspconfig' },
  { 'mfussenegger/nvim-dap' },
  { 'preservim/nerdtree',   cmd = { "NERDTreeToggle" } },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim', -- required
      'BurntSushi/ripgrep',    -- optional - grep
      'sharkdp/fd',            -- optional - find
    },
    init = function()
      local builtin = require 'telescope.builtin'
      nmap('<leader>ff', builtin.find_files)
      nmap('<leader>fg', builtin.live_grep)
      nmap('<leader>fb', builtin.buffers)
      nmap('<leader>fh', builtin.help_tags)
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        section_separators = { left = '', right = '' },
        component_separators = { left = '|', right = '|' },
        theme = 'material',
      },
      sections = {
        lualine_c = { { 'filename', path = 4 } },
        lualine_x = { 'encoding', 'filetype', 'tabs' },
        lualine_y = { 'tabs', 'windows' },
        lualine_z = { 'progress', 'location' },
      },
    },
  },

  -- Language tools
  { 'ray-x/go.nvim',                  ft = 'go', opts = {} },
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = 'dart',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {},
  },
  {
    'gruvw/strudel.nvim',
    build = 'npm install',
    config = function()
      require 'strudel'.setup({
        update_on_save = true,
      })
    end,
    init = function()
      local strudel = require 'strudel'
      vim.keymap.set('n', '<leader>sl', strudel.launch, { desc = 'Launch Strudel' })
      vim.keymap.set('n', '<leader>sq', strudel.quit, { desc = 'Quit Strudel' })
      vim.keymap.set('n', '<leader>st', strudel.toggle, { desc = 'Strudel Toggle Play/Stop' })
      vim.keymap.set('n', '<leader>su', strudel.update, { desc = 'Strudel Update' })
      vim.keymap.set('n', '<leader>ss', strudel.stop, { desc = 'Strudel Stop Playback' })
      vim.keymap.set('n', '<leader>sb', strudel.set_buffer, { desc = 'Strudel set current buffer' })
      vim.keymap.set('n', '<leader>sx', strudel.execute, { desc = 'Strudel set current buffer and update' })
    end,
  },

  -- Colors, UI
  { 'xiyaowong/transparent.nvim' },
  { 'hiphish/rainbow-delimiters.nvim' },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function() vim.cmd [[colorscheme catppuccin]] end,
  },
  { 'rafamadriz/neon',             lazy = true },
  { 'marko-cerovac/material.nvim', lazy = true },
  { 'Mofiqul/dracula.nvim',        lazy = true },
}
