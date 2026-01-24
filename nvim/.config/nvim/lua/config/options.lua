-- [[ Setting options ]]
-- See `:help vim.o`

-- vim.cmd.colorscheme("tokyonight-night")
-- indenting 2 spaces instead of 4
-- Add this to your init.lua
vim.o.winborder = "rounded"
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- set no wrap lines
vim.opt.wrap = false
-- Make line numbers default
vim.o.number = true
-- Make columns no more than 80 characters long
vim.opt.colorcolumn = "80"
-- You can also add relative line numbers, to help with jumping.
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function() end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 12

-- if performing an operation that would fail due to unsaved changes in the buffer
vim.o.confirm = true

-- Configure Diagnostics to show inline error text
vim.diagnostic.config({
    -- This controls the placement and style of the inline text
    virtual_text = {
        -- Set to true to show the error message inline
        -- This is what gives you the red text at the end of the line
        enable = true,

        -- A common convention is to display the error text aligned to the right.
        -- Options: 'eol' (end of line) or 'default' (right of the text)
        -- 'eol' is usually best for C-style languages.
        -- 'prefix' is the text that appears before the message (e.g., 'Error: ')
        format = function(diagnostic)
            -- Format the message to show the error code (if available)
            local code = diagnostic.code and " (" .. diagnostic.code .. ")" or ""
            return diagnostic.message .. code
        end,
        
        -- Style the virtual text (optional, defaults are usually good)
        severity = {
            min = vim.diagnostic.severity.HINT,
            max = vim.diagnostic.severity.ERROR,
        },
    },
    
    -- Other useful diagnostic settings:

    -- Show signs (icons) in the sign column (gutter)
    signs = {
        active = true,
        -- Define the text for the icons:
        text = {
            [vim.diagnostic.severity.ERROR] = "●",
            [vim.diagnostic.severity.WARN] = "●",
            [vim.diagnostic.severity.INFO] = "●",
            [vim.diagnostic.severity.HINT] = "○",
        }
    },

    -- Show diagnostics in the current line (undercurl/underline)
    underline = true,
    
    -- When the cursor hovers over a diagnostic, automatically show the full text in a floating window
    float = {
        source = true, -- Include source name
        focusable = false,
        header = "",
        prefix = " ",
        style = "minimal",
    },
})
