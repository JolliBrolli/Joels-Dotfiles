return {
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle", -- Lazy-load when the command is called
		keys = {
			-- Map <leader>u to toggle the Undotree window
			{ "<S-U>", "<cmd>UndotreeToggle<CR>", desc = "[U]ndo Tree" },
		},
		-- Optional: Configure persistence and auto-open behavior here if needed
		-- config = function()
		--   require('undotree').setup({
		--     -- settings go here
		--   })
		-- end
	},
}
