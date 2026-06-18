vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.cpp", "*.h", "*.hpp", "*.c", "*.cxx", "*.hpp", "*.hxx" },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end
})
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local opts = { buffer = args.buf }
    
    -- Map 'gd' to Go to Definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    -- Map 'gD' to Go to Declaration
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- Map 'K' to show native documentation (replaces the old system man pages!)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		-- Jump to the next/previous compiler error or warning
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = "Show Line Error" })

		-- Format the current file cleanly using Clang's styling rules
		vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, { desc = "Format Code" })
		
	end
})
return {
	cmd = { "clangd" },
	filetypes = { "cpp", "c" },
	root_markers = { 'compile_commands.json', 'Makefile', '.git' }
}

