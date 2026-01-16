vim.opt.termguicolors = true
return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = { 
        documentation = { auto_show = true },
        -- New location for formatting settings
        menu = {
          draw = {
            -- This replaces 'formatting.fields'
            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
          },
        },
      },

      -- Sources configuration remains the same
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- You can customize how source names appear here if needed
      },

      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}
