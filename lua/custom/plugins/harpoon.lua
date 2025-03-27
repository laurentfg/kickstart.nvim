return {
	{
		'ThePrimeagen/harpoon',


		--doit utiliser une fonction vu qu'il y a une variable local
		config = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")
	
			vim.keymap.set("n", "<leader>a", mark.add_file,{ desc = '[a]dd to Harpoon list' } )

			vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu)

			vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end )
			vim.keymap.set("n", "<C-j>", function() ui.nav_file(2) end )
			vim.keymap.set("n", "<C-k>", function() ui.nav_file(3) end )
			vim.keymap.set("n", "<C-l>", function() ui.nav_file(4) end )
			--vim.keymap.set("n", "<C-;>", function() ui.nav_file(5) end )
			--vim.keymap.set("n", "<C-è>", function() ui.nav_file(6) end )
			require('harpoon').setup({
			-- enable tabline with harpoon marks
				tabline = true
			})
			
			--hides tabline by default
			vim.opt.showtabline = 0
			
			vim.keymap.set("n",
			"<leader>A", 
			function()
				vim.opt.showtabline = ( vim.opt.showtabline:get() == 0) and 2 or 0
			end,
			{ desc = 'toggle t[A]bline' } )
			
		end,
	},
}