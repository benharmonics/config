require'lualine'.setup {
  options = {
    icons_enabled = false,
    section_separators = { left = '', right = '' },
    component_separators = { left = '|', right = '|' },
    theme = 'material',
    sections = {
      lualine_c = {{
        'filename',
        path = 4,
      }},
      lualine_x = { 'encoding', 'filetype', 'tabs' },
      lualine_y = { 'tabs', 'windows' },
      lualine_z = { 'progress', 'location' },
    }
  }
}
