-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	{
		vim.keymap.set('n', '<leader>x', "<cmd>!chmod +x %<CR>", { desc = 'make the file executable (Linux)' }),
		vim.keymap.set('n', '<leader>z', ":Telescope colorscheme<CR>", { desc = 'Select Colorscheme' }),
		
		--taken from Theprimeagen
		--slide the selected through the text like a box
		vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv"),
		vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv"),
		
		--cursor stays 
		vim.keymap.set("n", "J", "mzJ`z"),
		vim.keymap.set("n", "<C-d>", "<C-d>zz"),
		vim.keymap.set("n", "<C-u>", "<C-u>zz"),
		vim.keymap.set("n", "n", "nzzzv"),
		vim.keymap.set("n", "N", "Nzzzv"),
		--vim.keymap.set('n', '<leader>p', "\"_dP", { desc = 'Paste without replacing buffer' }),
		vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without replacing buffer' }),
		
		--put the yank in the OS register
		vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = 'yank to OS Register' }),
		vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'yank to OS Register' }),
		
		--movement stays centered in quickfix
		--vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz"),
		--vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz"),
		--vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz"),
		--vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz"),
		
		vim.keymap.set("n", "Q", "<nop>"),
		
		--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>"),
	}
  }
