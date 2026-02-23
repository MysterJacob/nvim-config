local notify = require("notify")
notify.setup({
  max_width = function()
    return math.floor(vim.api.nvim_win_get_width(0) * 0.4)
  end,
  render = "wrapped-compact",
  max_height = 10,
  stages = "fade_in_slide_out",
  level = "info",
  top_down = false,
  timeout=500,
}
)
vim.notify = notify
