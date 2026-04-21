return {
  -- Dracula
  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    lazy = false,
    priority = 1000,
  },

  -- Catppuccin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        which_key = true,
        mini = { enabled = true },
        cmp = false,
      },
    },
  },

  --tokyo night
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,

    -- configure and set on startup
    config = function()
      vim.g.adwaita_darker = true               -- for darker version
      vim.g.adwaita_disable_cursorline = true   -- to disable cursorline
      vim.g.adwaita_transparent = true          -- makes the background transparent
      vim.cmd('colorscheme adwaita')
    end
  },
}
