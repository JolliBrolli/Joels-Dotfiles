return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        -- Add specific filetypes here if needed, e.g.,
        -- 'css', 'javascript', 'html'
        "*", -- Highlight all files
      })
    end,
  },
}
