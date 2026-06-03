vim.pack.add { 'https://github.com/tpope/vim-fugitive' }
vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git [S]tatus' })
vim.keymap.set('n', '<leader>gm', '<CMD>G mergetool<CR>', { desc = 'Git [m]ergetool' })
