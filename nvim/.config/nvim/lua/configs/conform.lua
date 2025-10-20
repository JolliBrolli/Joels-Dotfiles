local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- You can uncomment these if you have 'prettier' installed:
    -- css = { "prettier" },
    -- html = { "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options -- Now 'options' is a defined table and can be returned.
