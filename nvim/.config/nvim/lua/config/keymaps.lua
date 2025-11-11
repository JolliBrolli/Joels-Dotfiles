-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.opt.hlsearch = true
-- Combined function for clearing both LSP and standard search highlights
local function clear_all_highlights()
  -- 1. Clear LSP reference highlights
  vim.lsp.buf.clear_references()

  -- 2. Clear standard search highlights (e.g., from * or / command)
  vim.cmd("nohlsearch")

  -- Returning true is usually necessary to ensure smooth <Esc> behavior
  -- and prevent it from interfering with other mappings/modes.
  return true
end

-- Assign the combined function to the <Esc> key in normal mode
vim.keymap.set("n", "<Esc>", clear_all_highlights, {
  desc = "Clear LSP and Search Highlights"
})

-- standard QOL Keymaps
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { desc = "Next diagnostic error" })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { desc = "Previous diagnostic error" })
vim.keymap.set("n", "<leader>ln", ":set number!<CR>", { desc = "[L]ine [N]umbers" })
vim.keymap.set("n", "<leader>lrn", ":set relativenumber!<CR>", { desc = "[R]elative [L]ine [N]umbers" })
-- Corrected Custom function to close utility/plugin windows
local function close_utility_windows()
	-- Get the list of windows and iterate in REVERSE order for safe closing
	local wins = vim.api.nvim_tabpage_list_wins(0)

	-- Iterate from the last window ID to the first
	for i = #wins, 1, -1 do
		local winid = wins[i]

		-- Do not close the current window
		if winid == vim.api.nvim_get_current_win() then
			goto continue -- Skip to the next iteration
		end

		local bufnr = vim.api.nvim_win_get_buf(winid)
		local buftype = vim.api.nvim_buf_get_option(bufnr, "buftype")
		local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

		-- Check for common utility window types
		if buftype ~= "" or filetype == "neo-tree" or filetype == "undotree" then
			-- Close the window. 'true' means force close (like :q!)
			-- This needs to be the safest way to close: `vim.api.nvim_win_close`
			vim.api.nvim_win_close(winid, true)
		end

		::continue:: -- Label for the goto
	end
end

-- Keymap for closing utility windows (Keep this as is)
vim.keymap.set("n", "<leader>qq", close_utility_windows, { desc = "Close utility/plugin windows (keep file splits)" })
-- Neotree Keymaps
-- NOTE: Neotree keymaps are general enough to live here, but you could move them
--       into the neo-tree plugin config if you decide to load that plugin later.
vim.keymap.set("n", "<C-n>", ":Neotree toggle left<CR>")
vim.keymap.set("n", "<leader>n", ":Neotree focus<CR>", { desc = "[N]eotree focus" })
-- UndoTree Keymaps
vim.keymap.set("n", "<C-u>", "<cmd>UndotreeToggle<CR>", { desc = "[U]ndo Tree" })
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>qf", vim.diagnostic.setloclist, { desc = "[Q]uickfix list" })

-- Exit terminal mode in the builtin terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-S-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-S-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })

-- LSP Keybinds
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {}, { desc = "Go to Defintion" })
vim.keymap.set("n", "<S-K>", vim.lsp.buf.hover, {}, { desc = "Get Description" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {}, { desc = "Go to Code Actions" })
-- Formatting Keyinds
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
-- Telescope keybinds
-- NOTE: We must require "telescope.builtin" here to use the 'builtin' variable
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })

-- set of commands to highlight all references, and be able to move between them
local function list_and_highlight_references()
	-- 1. **HIGHLIGHTING:** This is the function that asks the LSP
	-- to visually highlight all references in the current buffer.
	vim.lsp.buf.document_highlight()

	-- 2. **NAVIGATION:** This is your original Telescope command.
	-- It executes right after the highlighting starts.
	-- Even if you configured Telescope to immediately jump or use a tiny peek,
	-- this is the right function to call to initiate that navigation.
	require("telescope.builtin").lsp_references()
end

-- Assign the combined action to your keybind
vim.keymap.set("n", "<leader>sr", list_and_highlight_references, {
	desc = "Highlight and Navigate LSP References",
})

-- End of highlighting references block
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
-- Keymap using a custom function (requires a local function definition)
vim.keymap.set("n", "<leader>/", function()
	-- You must require the theme here if you want to use it
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })
-- Shortcut for searching your Neovim configuration files (requires a local function definition)
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
-- Harpoon Keybinds
vim.keymap.set("n", "<leader>a", function()
	require("harpoon"):list():add()
end, { desc = "[H]arpoon: Add File" })

vim.keymap.set("n", "<C-e>", function()
	-- Access harpoon.ui and harpoon:list() via require()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end, { desc = "[H]arpoon: Toggle Quick Menu" })

vim.keymap.set("n", "<leader>1", function()
	require("harpoon"):list():select(1)
end, { desc = "[H]arpoon: Go to Mark 1" })

vim.keymap.set("n", "<leader>2", function()
	require("harpoon"):list():select(2)
end, { desc = "[H]arpoon: Go to Mark 2" })

vim.keymap.set("n", "<leader>3", function()
	require("harpoon"):list():select(3)
end, { desc = "[H]arpoon: Go to Mark 3" })

vim.keymap.set("n", "<leader>4", function()
	require("harpoon"):list():select(4)
end, { desc = "[H]arpoon: Go to Mark 4" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
	require("harpoon"):list():prev()
end, { desc = "Harpoon: Previous Mark" })

vim.keymap.set("n", "<C-S-N>", function()
	require("harpoon"):list():next()
end, { desc = "Harpoon: Next Mark" })
-- Debugging Keybinds
local dap, dapui = require("dap")
vim.keymap.set("n", "<Leader>db", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dc", dap.continue, {})
vim.keymap.set("n", "<Leader>de", dap.disconnect, {})
-- CMake Keybinds
vim.keymap.set("n", "<Leader>cg", ":CMakeGenerate<CR>", { desc = "[C]Make[G]enerate" })
vim.keymap.set("n", "<Leader>cb", ":CMakeBuild<CR>", { desc = "[C]Make[B]uild" })
vim.keymap.set("n", "<Leader>cr", ":CMakeRun<CR>", { desc = "[C]Make[R]un" })
-- Keymap to close the current window/split (e.g., terminal output from CMake)
vim.keymap.set("n", "<Leader>ct", ":CMakeRunTest<CR><C-w>j", { desc = "[C]MakeRun[T]est" })
