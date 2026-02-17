local notify = require("notify")
notify.setup({
  max_width = function()
    return math.floor(vim.api.nvim_win_get_width(0) * 0.7)
  end,
  max_height = 10,
  stages = "fade_in_slide_out",
}
)
vim.notify = notify
