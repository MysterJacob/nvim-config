require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = 'material',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      'packer', 'NvimTree', 'notfiy',
    },
    ignore_focus = { 'NvimTree' },
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})
-- require('lualine').setup({
--   options = {
--     theme = 'auto',
--     globalstatus = true,
--     refresh = { statusline = 0 }
--   },
--   sections = { lualine_a = {'mode'}, lualine_b = {'branch'}, lualine_c = {'filename'} }
-- })
-- 
