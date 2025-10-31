-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- standard QOL Keymaps
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { desc = "Next diagnostic error" })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { desc = "Previous diagnostic error" })
vim.keymap.set("n", "<leader>ln", ":set number!<CR>", { desc = "[L]ine [N]umbers" })
vim.keymap.set("n", "<leader>lrn", ":set relativenumber!<CR>", { desc = "[R]elative [L]ine [N]umbers" })

-- Neotree Keymaps
-- NOTE: Neotree keymaps are general enough to live here, but you could move them
--       into the neo-tree plugin config if you decide to load that plugin later.
vim.keymap.set("n", "<S-n>", ":Neotree toggle left<CR>")
vim.keymap.set("n", "<leader>n", ":Neotree focus<CR>", { desc = "[N]eotree focus" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "[Q]uickfix list" })

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
vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<S-K>", vim.lsp.buf.hover, {})
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
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
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
local dap, dapui = require("dap"), require("dapui")
vim.keymap.set("n", "<Leader>db", function()
	dap.toggle_breakpoint()
end)
vim.keymap.set("n", "<Leader>dc", dap.continue, {})
