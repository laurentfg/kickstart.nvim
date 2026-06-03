--prerequisites
vim.pack.add{"https://github.com/nvim-lua/plenary.nvim"}
vim.pack.add{"https://github.com/MunifTanjim/nui.nvim"}

--plugin
vim.pack.add{"https://github.com/adibhanna/laravel.nvim"}

vim.keymap.set('n', "<leader>la", "<cmd>Artisan<CR>", {desc = "Laravel Artisan"} )
vim.keymap.set('n', "<leader>lc", "<cmd>Composer<CR>", {desc = "Composer"} )
vim.keymap.set('n', "<leader>lr", "<cmd>LaravelRoute<CR>", {desc = "Laravel Routes"} )
vim.keymap.set('n', "<leader>lm", "<cmd>LaravelMake<CR>", {desc = "Laravel Make"} )

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.filereadable("artisan") == 1 then
      pcall(function()
        require("laravel").setup({})
      end)
    end
  end,
})