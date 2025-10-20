local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local lspconfig = require("lspconfig")
local util = require("lspconfig.util")


-- C# (OmniSharp)
lspconfig.omnisharp.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  filetypes = { "cs" },
  root_dir = util.root_pattern(".sln", ".csproj", ".git"),
}

-- XML (LemMinX)
lspconfig.lemminx.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "xml" },
}
