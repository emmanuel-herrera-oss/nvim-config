return {
	cmd = { 'clangd', '--fallback-style=Google' },
	filetypes = { 'cpp', 'c' },
	root_markers = { 'compile_commands.json', 'Makefile', '.git', 'CMakeLists.txt' }
}
