-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
	{
		vim.keymap.set('n', '<leader>x', "<cmd>!chmod +x %<CR>", { desc = 'make the file executable (Linux)' }),
		vim.keymap.set('n', '<leader>z', ":Telescope colorscheme<CR>", { desc = 'Select Colorscheme' }),
		
		vim.keymap.set('n', '<leader>Z', ":luafile ~/appdata/local/nvim/init.lua<CR>", { desc = 'Select Colorscheme' }),
		
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
		
		--obsolete since capital P works now for that
		--vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without replacing buffer' }),		
		
		--put the yank in the OS register
		vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = 'yank to OS Register' }),
		vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'yank to OS Register' }),
		
		
		--movement stays centered in quickfix
		vim.keymap.set("n", "<M-n>", "<cmd>cnext<CR>zz"),
		vim.keymap.set("n", "<M-p>", "<cmd>cprev<CR>zz"),
		vim.keymap.set("n", "<leader>n", "<cmd>lnext<CR>zz", { desc = "Quickfix [N]ext" } ),
		vim.keymap.set("n", "<leader>p", "<cmd>lprev<CR>zz", { desc = "Quickfix [P]revious" } ),
		
		
		vim.keymap.set("n", "Q", "<C-^>"),
		--imitate a basic shortcut (replaced by command above
		--vim.keymap.set("x", "<leader>^", ":e #^M", {desc = 'return to previous file [^]'}),
		
		--pour Oil.nvim
		vim.keymap.set("n", "<leader>o", "<CMD>Oil<CR>", { desc = "[O]pen parent directory" }),
		
		--enter a manual command to apply on visual blocks/v-lines
		vim.keymap.set('x', '<leader>n', ':norm ', {desc = "[n]ormal cmd on highlight" } ),
		
		--vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>"),
		
		vim.keymap.set("n", "<M-Left>",  "<cmd>vertical resize -5<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<M-Right>", "<cmd>vertical resize +5<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<M-Up>",    "<cmd>resize +5<CR>", { noremap = true, silent = true }),
		vim.keymap.set("n", "<M-Down>",  "<cmd>resize -5<CR>", { noremap = true, silent = true }),
		
		--made by ChatGPT, imitates the behavior of IntelliJ
		--where opening { right before a ) will create the { after instead of before the )

		--code ne marche pas, donc enlevé
		
		vim.keymap.set("n", "<M-q>",  "<cmd>ClangdSwitchSourceHeader<CR>", { noremap = true, silent = true }),
		
		

	} 
  }
