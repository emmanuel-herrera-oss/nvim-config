return {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	settings = {
		Lua = {
			format = {
				enable = true,
				defaultConfig = {
					quote_style = 'single',
				},
			},
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = {
					vim.env.VIMRUNTIME,
				},
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
}
