-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	{
		vim.keymap.set('n', '<leader>p', "\"_dP", { desc = 'Paste without replacing buffer' }),
		vim.keymap.set('n', '<leader>x', "<cmd>!chmod +x %<CR>", { desc = 'make the file executable (Linux)' }),
		vim.keymap.set('n', '<leader>z', ":Telescope colorscheme<CR>", { desc = 'Select Colorscheme' }),
	}
  }
