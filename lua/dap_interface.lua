require "map"
local dap = require('dap')
local dapui = require('dapui')
local telescope = require('telescope')
local tree = require("nvim-tree.api")

-- Text
require("nvim-dap-virtual-text").setup({
  commented = true,
  virt_text_pos = 'eol'
})

-- Ui
vim.api.nvim_set_hl(0, "red", { fg = "#ff1000" })
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

local isDapRunning = false;
vim.api.nvim_create_autocmd({ "VimResized", "BufEnter" }, {
  callback = function()
    if package.loaded["dapui"] and isDapRunning then
      dapui.open({ reset = true });
    end
  end,
})

dapui.setup(
  {
    layouts = {
      {
        position = "left",
        size = 55,
        elements = {
          { id = "repl" },
          { id = "watches", size = 0.2 },
          { id = "scopes",  size = 0.3 },
        }
      },
      {
        position = "bottom",
        size = 0.2,
        elements = {
          { id = "console" },
        }
      }
    },
    controls = {
      enabled = true,
      element = "scopes"
    }
  })

dap.adapters.codelldb = {
  type = 'server',
  port = '${port}',
  executable = {
    command = vim.fn.stdpath('data') .. "/mason/bin/codelldb",
    args = { '--port', '${port}' },
  },
}
dap.adapters.gdb = {
  id = 'gdb',
  type = 'executable',
  command = 'gdb',
  args = { '--quiet', '--interpreter=dap' },
}

vim.keymap.set('n', '<leader>ds',
  function()
    tree.tree.close()
    dapui.open({ reset = true })
    dap.continue()
    isDapRunning = true;
    vim.opt.mouse = "a"
  end, {})
vim.keymap.set("n", "<leader>dq", function()
  dap.terminate()
  dapui.close()
  isDapRunning = false;
  vim.opt.mouse = nil
end)
vim.keymap.set("n", "<leader>dB", function()
  dap.set_breakpoint(vim.fn.input '[Condition] > ')
end)
vim.keymap.set("n", "<leader>db", function()
  dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<leader>de", function()
  dapui.eval(vim.fn.input('[Expression] > '))
end)
vim.keymap.set("n", "<leader>dc", function()
  dap.run_to_cursor()
end)
vim.keymap.set("n", "<F10>", function()
  dap.step_over()
end)
vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end)
vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end)
vim.keymap.set("n", "<leader>tc", function()
  telescope.extensions.dap.commands({})
end)

dap.configurations.c = {
  {
    name = "Compile & Debug current file",
    type = "codelldb",
    request = "launch",
    program = function()
      local file = vim.fn.expand("%:p")
      local out  = vim.fn.expand("%:p:r")
      local cmd  = string.format("gcc -g -o %s %s", out, file)
      local code = os.execute(cmd)
      if code ~= 0 then
        vim.notify("Compilation failed!", vim.log.levels.ERROR)
        return dap.ABORT
      end
      return out
    end,
    stopAtEntry = true,
  },
  {
    name = "Compile & Debug using make",
    type = "codelldb",
    request = "launch",
    program = function()
      local code = os.execute("make debug")
      if code ~= 0 then
        vim.notify("Compilation failed!", vim.log.levels.ERROR)
        return dap.ABORT
      end
    end,
    stopAtEntry = true,
  },
}
dap.configurations.cpp = dap.configurations.c
require('dap-python').setup('python3')

telescope.load_extension("dap")
