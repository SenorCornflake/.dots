vim.g.rnvimr_enable_ex = true
vim.g.rnvimr_enable_picker = true

RnvimRSettings = function()
	local lines = vim.api.nvim_exec("echo &lines", true)
	local columns = vim.api.nvim_exec("echo &columns", true)

	vim.g.rnvimr_layout = {
		relative = 'editor',
		width = math.floor(0.95 * columns),
		height = math.floor(0.85 * lines),
		col = math.floor(0.035 * columns),
		row = math.floor(0.08 * lines),
		style = 'minimal'
	}
end
RnvimRSettings()

vim.cmd "autocmd VimResized * lua RnvimRSettings()"
