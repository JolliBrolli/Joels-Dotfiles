return {
	{ "nicholasmata/nvim-dap-cs", dependencies = { "mfussenegger/nvim-dap" } },
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
