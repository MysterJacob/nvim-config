require "map"
local dap = require('dap')
local dapui = require('dapui')
local telescope = require('telescope')

-- Text
require("nvim-dap-virtual-text").setup({})
-- Ui
vim.api.nvim_set_hl(0, "red", { fg = "#ff1000" })
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'red', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

dapui.setup(
  {
    layouts = {
      {
        elements = {
          "watches",
          { id = "scopes", size = 0.5 },
          { id = "repl",   size = 0.15 },
        },
        size = 30,
        position = "left",
      },
      {
        elements = {
          "console",
        },
        size = 0.25,
        position = "bottom",
      },
    },
    controls = {
      enabled = true,
      element = "repl",
      icons = {
            pause = "⏸️",
            play = "▶️",
            step_into = "🔽",
            step_over = "⏭️",
            step_out = "🔼",
            step_back = "◀️",
            run_last = "⏹️",
            terminate = "⏹️",
      },
    },
  })

-- codelldb
dap.adapters.lldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/usr/bin/lldb",
    args = { "--port", "${port}" },
  },
}
-- Bindings
vim.keymap.set('n', '<F9>',
  function()
    dap.continue()
    vim.opt.mouse = "a"
    dapui.open()
  end, {})
-- Exit
vim.keymap.set("n", "<F7>", function()
  dap.terminate()
  dapui.close()
  vim.cmd("sleep 50ms")
  dap.repl.close()
  vim.opt.mouse = nil
end)
-- Restart
vim.keymap.set("n", "<F21>", function()
  dap.terminate()
  vim.cmd("sleep 50ms")
  dap.repl.close()
  dap.continue()
end) -- Shift F9
vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<F8>", function()
  dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<F20>", function()
  dap.clear_breakpoints()
end) -- SHIFT+F8
vim.keymap.set("n", "<F10>", function()
  dap.step_over()
end)
vim.keymap.set("n", "<leader>rc", function()
  dap.run_to_cursor()
end)
vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end)
vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end)
-- vim.keymap.set("n", "<leader>dp", function()
--     dap.pause()
-- end)
vim.keymap.set("n", "<leader>dtc", function()
  telescope.extensions.dap.commands({})
end)

local function file_exists(name)
  local f = io.open(name, "r")
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end
-- CPP
dap.configurations.cpp = {
  {
    -- Change it to "cppdbg" if you have vscode-cpptools
    type = "lldb",
    request = "launch",
    program = function()
      local name = "filenotfound"
      local makefilePresent = file_exists("makefile")
      if makefilePresent then
        vim.print("make debug")
        os.execute("make debug > /dev/null 2>&1")
        name = "debug"
      else
        local filetype = vim.bo.filetype
        local filename = vim.fn.expand("%")
        local basename = vim.fn.expand('%:t:r')
        if filetype == "c" then
          os.execute(string.format("gcc -g -o %s %s", basename, filename))
        else
          os.execute(string.format("g++ -g -o %s %s", basename, filename))
        end
        name = basename
      end
      require('nvim-tree.api').tree.close()
      return name
    end,
    args = function()
      local argv = {}
      arg = vim.fn.input(string.format("argv: "))
      for a in string.gmatch(arg, "%S+") do
        table.insert(argv, a)
      end
      vim.cmd('echo ""')
      return argv
    end,
    cwd = "${workspaceFolder}",
    -- Uncomment if you want to stop at main
    -- stopAtEntry = true,
    MIMode = "gdb",
    miDebuggerPath = "/usr/bin/gdb",
    setupCommands = {
      {
        text = "-enable-pretty-printing",
        description = "enable pretty printing",
        ignoreFailures = false,
      },
    },
  },
}
-- You can even copy configurations
dap.configurations.c = dap.configurations.cpp

-- Python
local python_path = table.concat({ vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/')
    :gsub('//+', '/')
require('dap-python').setup(python_path)
