-- 1. Enable wrapping (the 'fake' new lines)
vim.opt_local.wrap = true

-- 2. THE BIG ONE: Only wrap at whole words (no breaking 'th-is')
vim.opt_local.linebreak = true

-- 3. Keep the indentation for wrapped lines (makes lists/paragraphs look pro)
vim.opt_local.breakindent = true

-- Optional: Turn off textwidth so it doesn't 'hard break' while you type
vim.opt_local.textwidth = 0
