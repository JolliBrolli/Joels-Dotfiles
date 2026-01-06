return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Load early to ensure the colorscheme is set first

		config = function()
			require("catppuccin").setup({
				-- Choose your flavor: "mocha" (default dark), "macchiato", "frappe", or "latte" (light).
				flavour = "mocha",

				-- If set to true, the background color will not be set, allowing terminal transparency to show.
				transparent_background = false,

				-- Style overrides (e.g., forcing no italics on comments)
				styles = {
					comments = {}, -- Empty table removes the default "italic" style
				},

				-- Integrations for supported plugins (many are enabled by default)
				integrations = {
					-- Explicitly add support for which-key.nvim
					which_key = true,

					-- Custom configuration for mini.nvim's indent scope (enabled by default)
					mini = {
						enabled = true,
						indentscope_color = "sapphire",
					},

					-- Since you use blink.cmp, ensure its LSP client is styled (enabled by default as 'cmp')
					cmp = true,
				},
			})

			-- Load the colorscheme once setup is complete
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
