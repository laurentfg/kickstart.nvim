return {
  {
    'rest-nvim/rest.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'http')
      end,
    },
    vim.keymap.set('n', '<leader>ro', '<cmd>Rest open<CR>', { desc = 'Rest [o]pen' }),
    vim.keymap.set('n', '<leader>rr', '<cmd>Rest run<CR>', { desc = 'Rest [r]un' }),
    vim.keymap.set('n', '<leader>rt', '<cmd>Rest last<CR>', { desc = 'Rest las[t] request' }),
    vim.keymap.set('n', '<leader>rl', '<cmd>Rest logs<CR>', { desc = 'Rest [l]ogs' }),
    vim.keymap.set('n', '<leader>rc', '<cmd>Rest cookies<CR>', { desc = 'Rest edit [c]ookies' }),
    vim.keymap.set('n', '<leader>re', '<cmd>Rest env show<CR>', { desc = 'Rest show dot[e]nv' }),
    vim.keymap.set('n', '<leader>rs', '<cmd>Rest env select<CR>', { desc = 'Rest [s]elect .env file' }),

    vim.keymap.set(
      'n',
      '<leader>rv',
      ':execute "Rest env set " . getreg(\'"\')<CR>',
      { noremap = true, silent = true, desc = 'Rest: set .en[v] from yank register' }
    ),
    --vim.keymap.set("n", "<leader>rR", "<cmd>Rest run ", {desc = "Rest [R]un with name"}),
  },
}

