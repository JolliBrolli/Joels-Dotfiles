return {
	"nvimtools/none-ls.nvim",

	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
	},
	config = function()
		local null_ls = require("null-ls")
		local b = null_ls.builtins

		null_ls.setup({
			sources = {
				-- JS/TS/CSS/JSON/HTML (FORMATTING)
				-- Prettier is a great multi-language formatter for web/config files.
				b.formatting.prettier,

				-- LUA (FORMATTING)
				b.formatting.stylua,

				-- JAVASCRIPT/TYPESCRIPT (LINTING)
				b.diagnostics.eslint_d,

				-- HTML (LINTING)
				b.diagnostics.htmlhint,

				-- YAML (LINTING/DIAGNOSTICS)
				-- yamllint checks for syntax errors, key repetition, and style.
				b.diagnostics.yamllint,

				-- JSON (LINTING)
				-- jsonlint checks for valid JSON syntax.
				b.diagnostics.jsonlint,

				-- XML (LINTING & FORMATTING)
				-- XML formatting and basic diagnostics can often be done by Prettier,
				-- but HTML Tidy is an excellent dedicated XML/HTML checker for advanced validation.
				b.diagnostics.tidy,
				b.formatting.tidy,

				-- LUA (LINTING)
				-- Luacheck is the standard linter for Lua.
				b.diagnostics.luacheck,
			},
		})
	end,
}
