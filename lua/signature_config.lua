local signature_config = {
  debug = false,
  verbose = false,
  bind = true,
  doc_lines = 10,
  max_height = 3,
  max_width = 70,
  wrap = true,
  floating_window = true,
  floating_window_above_cur_line = true,
  floating_window_off_x = 0,

  floating_window_off_y = 0,

  close_timeout = 500,
  fix_pos = false,
  hint_enable = false,
  hint_prefix = "",
  hint_scheme = "String",
  hint_inline = function() return false end,
  hi_parameter = "LspSignatureActiveParameter",
  handler_opts = {
    border = "rounded"
  },
  always_trigger = true,
  auto_close_after = nil,
  extra_trigger_chars = {},
  zindex = 200,
  padding = '',
  transparency = nil,
  shadow_blend = 36,
  shadow_guibg = 'Black',
  timer_interval = 200,
  toggle_key = nil,
  toggle_key_flip_floatwin_setting = false,
  select_signature_key = nil,
  move_signature_window_key = nil,
  move_cursor_key = nil,
  keymaps = {}
}

local lsp_signature = require("lsp_signature")
lsp_signature.setup(signature_config)
