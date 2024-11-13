local signature_config = {
  bind = true,
  always_trigger = false,
  handler_opts = {
    border = "rounded"
  }
  --     transparency=1
}
local lsp_signature = require("lsp_signature")
lsp_signature.setup(signature_config)
