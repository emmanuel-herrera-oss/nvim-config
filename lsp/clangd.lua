vim.api.nvim_create_autocmd('BufWritePre', {
	pattern = { '*.c', '*.cc', '*.cpp', '*.cxx', '*.h', '*.hpp', '*.hxx', '*.ts', '*.tsx', '*.lua' },
	callback = function()
		vim.lsp.buf.format({ async = false })
	end
})
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local opts = { buffer = args.buf }
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next Diagnostic' })
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous Diagnostic' })
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'Show Line Error' })
		vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, { desc = 'Format Code' })
	end
})
return {
	cmd = { 'clangd', '--fallback-style=Google' },
	filetypes = { 'cpp', 'c' },
	root_markers = { 'compile_commands.json', 'Makefile', '.git', 'CMakeLists.txt' }
}
