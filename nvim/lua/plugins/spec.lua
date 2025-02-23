local function nmap(shortcut, command, opts)
  vim.keymap.set('n', shortcut, command, opts)
end

return {
  { 'mfussenegger/nvim-dap' },
  { 'preservim/nerdtree' },
  { 'hiphish/rainbow-delimiters.nvim' },
  {
    'shortcuts/no-neck-pain.nvim',
    version = '*',
    opts = { autocmds = { enableOnVimEnter = true } } ,
  },

  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    init = function()
      local builtin = require'telescope.builtin'
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
  { 'ray-x/go.nvim', opts = {} },
  {
    'simrat39/rust-tools.nvim',
    opts = function()
      local rt = require'rust-tools'
      return {
        server = {
          on_attach = function(_, bufnr)
            -- Hover actions
            nmap('<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            nmap('<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
          end,
        },
      }
    end,
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    opts = {},
  },

  -- Colorschemes
  {
    'xiyaowong/transparent.nvim',
    lazy = false,
    build = ':TransparentEnable',
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd[[colorscheme catppuccin]]
    end,
  },
  { 'rafamadriz/neon' },
  { 'marko-cerovac/material.nvim' },
  { 'Mofiqul/dracula.nvim' },
}
