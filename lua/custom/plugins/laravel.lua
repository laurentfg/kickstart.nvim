vim.pack.add{"https://github.com/adibhanna/laravel.nvim"}

vim.keymap.set('n', "<leader>la", "<cmd>Artisan<CR>", {desc = "Laravel Artisan"} )
vim.keymap.set('n', "<leader>lc", "<cmd>Composer<CR>", {desc = "Composer"} )
vim.keymap.set('n', "<leader>lr", "<cmd>LaravelRoute<CR>", {desc = "Laravel Routes"} )
vim.keymap.set('n', "<leader>lm", "<cmd>LaravelMake<CR>", {desc = "Laravel Make"} )

require("laravel").setup{}