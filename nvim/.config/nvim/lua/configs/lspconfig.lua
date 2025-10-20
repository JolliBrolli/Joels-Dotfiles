-- Load NvChad defaults
local nvchad_lsp = require "nvchad.configs.lspconfig"

local on_attach = nvchad_lsp.on_attach
local capabilities = nvchad_lsp.capabilities

-- REMOVE OMNISHARP CONFIGURATION HERE

vim.lsp.config["lemminx"] = {
  cmd = { "lemminx" },
  filetypes = { "xml" },
  on_attach = on_attach,
  capabilities = capabilities,
}

vim.lsp.config("roslyn", {
  on_attach = on_attach,
  capabilities = capabilities,
  -- roslyn.nvim handles most configuration, but you can pass common lspconfig
  -- options like on_attach here.
})

-- Enable them
vim.lsp.enable { "roslyn", "lemminx", "html", "cssls" }
