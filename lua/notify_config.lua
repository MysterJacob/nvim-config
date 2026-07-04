local notify = require("notify")
notify.setup({
  max_width = function()
    return math.max(50, math.floor(vim.api.nvim_win_get_width(0) * 0.4))
  end,
  render = "wrapped-compact",
  max_height = 10,
  minimum_width = 50,
  stages = "fade_in_slide_out",
  level = "info",
  top_down = false,
  timeout = 500,
  background_colour = "#000000",
}
)
vim.notify = notify
