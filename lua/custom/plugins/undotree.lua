vim.pack.add{'https://github.com/mbbill/undotree'}

vim.g.undotree_DiffCommand = 'FC', vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Open [U]ndotree panel' })