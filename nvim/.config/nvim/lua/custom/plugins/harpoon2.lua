return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- IMPORTANT: Call setup statically (using dot) and pass an empty table.
			-- This avoids the previous hidden serialization error.
			require("harpoon").setup({})

			-- Custom Telescope UI Integration for Harpoon2
			local conf = require("telescope.config").values
			local function toggle_telescope(harpoon_files)
				local file_paths = {}
				for _, item in ipairs(harpoon_files.items) do
					-- Use item.filename for harpoon2 compatibility, as it stores the full path
					table.insert(file_paths, item.filename)
				end

				require("telescope.pickers")
					.new({}, {
						prompt_title = "Harpoon",
						finder = require("telescope.finders").new_table({
							results = file_paths,
						}),
						previewer = conf.file_previewer({}),
						sorter = conf.generic_sorter({}),
					})
					:find()
			end
		end,
	},
}
