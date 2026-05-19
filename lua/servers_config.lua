local function on_attach(ev, bfrn)
  local opts = {}
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)

  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  vim.keymap.set('n', '[d',
    (function()
      vim.diagnostic.jump({ count = -1, float = true })
    end))
  vim.keymap.set('n', ']d',
    (function()
      vim.diagnostic.jump({ count = 1, float = true })
    end))
  vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts)

  vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    vim.lsp.buf.format { async = true }
  end, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true;
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

-- Diagnostic settings
vim.diagnostic.config {
  virtual_text = false,
  float = {
    severity_sort = true,
    source = "if_many",
  },
  severity_sort = true,
  signs = false,
  underline = true,
}

local function setupServer(name, config)
  vim.lsp.config(name, config)
  vim.lsp.enable(name, config)
end
-- Servers
setupServer("clangd", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    root_dir = vim.loop.cwd(),
  },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=never",
  }
}
)
setupServer("glsl_analyzer", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    root_dir = vim.loop.cwd(),
  }
})
setupServer("asm_lsp", {});

setupServer("rust_analyzer", {
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = true,
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      procMacro = {
        enable = true,
      }
    }
  },
  capabilities = capabilities,
  on_attach = on_attach
})

setupServer("ruff", {
  capabilities = capabilities,
  on_attach = on_attach,
  init_options = {
    settings = {
      configurationPreference = "filesystemFirst",
      lineLength = 80,
      showSyntaxErrors = false,
    },
    configuration = {
      lint = {
        unfixable = { "F401" },
        ["extend-select"] = { "TID251" },
        ["flake8-tidy-imports"] = {
          ["banned-api"] = {
            ["typing.TypedDict"] = {
              msg = "Use `typing_extensions.TypedDict` instead"
            }
          }
        }
      },
      format = {
        ["quote-style"] = "double"
      }
    }
  }
})

setupServer("pyright", {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = false,
        diagnosticMode = "openFilesOnly",
        useLibraryCodeForTypes = false,
        typeCheckingMode = false
      }
    }
  }
})

setupServer("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = on_attach
})


setupServer("html", {
  capabilities = capabilities,
  on_attach = on_attach
})

setupServer("cssls", {
  capabilities = capabilities,
  on_attach = on_attach
})

setupServer("eslint", {
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})

setupServer("ts_ls", {
  capabilities = capabilities,
  on_attach = on_attach,
  single_file_support = true,
})

setupServer("vuels", {
  capabilities = capabilities,
  on_attach = on_attach,
  config = {
    css = {},
    emmet = {},
    html = {
      suggest = {}
    },
    javascript = {
      format = {}
    },
    stylusSupremacy = {},
    typescript = {
      format = {}
    },
    vetur = {
      completion = {
        autoImport = false,
        tagCasing = "kebab",
        useScaffoldSnippets = false
      },
      format = {
        defaultFormatter = {
          js = "none",
          ts = "none"
        },
        defaultFormatterOptions = {},
        scriptInitialIndent = false,
        styleInitialIndent = false
      },
      useWorkspaceDependencies = false,
      validation = {
        script = true,
        style = true,
        template = true
      }
    }
  }
})

setupServer("kotlin_language_server", {});
setupServer("jdtls", {});
