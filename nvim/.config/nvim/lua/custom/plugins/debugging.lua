return {
	{ "nicholasmata/nvim-dap-cs", dependencies = { "mfussenegger/nvim-dap" } },
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
		},
		opts = {
			handlers = {},
			ensure_installed = {

				"codelldb",
			}
		},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")

			-- 1. Setup plugins that depend on DAP
			require("dap-cs").setup({ netcoredbg_path = "/usr/bin/netcoredbg" })
			require("dapui").setup()
			-- C++ Debugger
			require("dap").adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					command = "codelldb", -- or the full path to codelldb
					args = { "--port", "${port}" },
				},
			}

			require("dap").configurations.cpp = {
				{
					name = "Launch",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = true,
				},
			}

			-- 4. Setup DAP UI listeners
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},
}
