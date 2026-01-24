-- colors/haidang.lua
-- This file lets you type ':colorscheme haidang'

-- Clear existing highlights
vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

-- Set the theme name
vim.g.colors_name = 'haidang'

-- Load your Lush file
local lush = require('lush')
local theme = require('Hai-Dang.init')

-- Apply it
lush(theme)
