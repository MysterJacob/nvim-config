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

-- codelldb
dap.adapters.lldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = "/usr/bin/lldb",
    args = { "--port", "${port}" },
  },
}
vim.keymap.set('n', '<leader>ds',
  function()
    tree.tree.close()
    dapui.open()
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
    name = "cpp",
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
    --     stopAtEntry = true,
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
-- local python_path = table.concat({ vim.fn.stdpath('data'), 'mason', 'packages', 'debugpy', 'venv', 'bin', 'python' }, '/')
--     :gsub('//+', '/')
require('dap-python').setup('python3')

telescope.load_extension("dap")
