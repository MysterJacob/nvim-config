local cfg = {
  debug = false,
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
  verbose = false,
  bind = true,
  doc_lines = 0,
  max_height = 5,
  max_width = function()
    return math.floor(vim.api.nvim_win_get_width(0) * 0.8)
  end,
  wrap = true,
  floating_window = true,
  floating_window_above_cur_line = true,
  floating_window_off_x = 1,
  floating_window_off_y = 0,
  close_timeout = 4000,
  fix_pos = false,
  hint_enable = false,
  hint_prefix = "🤓☝️ ",

  hint_scheme = "String",
  hint_inline = function() return false end,
  hi_parameter = "LspSignatureActiveParameter",
  handler_opts = {
    border = "shadow"
  },

  always_trigger = true,

  auto_close_after = nil,
  extra_trigger_chars = {},
  zindex = 200,

  padding = '',
  transparency = nil,
  shadow_blend = 36,
  shadow_guibg = '#101010',
  timer_interval = 200,
  toggle_key = nil,
  toggle_key_flip_floatwin_setting = false,

  select_signature_key = nil,
  move_signature_window_key = nil,

  move_cursor_key = nil,
  keymaps = {}
}


require 'lsp_signature'.setup(cfg)
