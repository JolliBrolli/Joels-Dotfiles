return {
  -- Highlight todo, notes, etc in comments
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false },
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
      },
    config = function ()
      require('Comment').setup()
    end
  }

}
