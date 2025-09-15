return {
  {
    'sindrets/diffview.nvim',

    config = function()
      local actions = require 'diffview.actions'
      require('diffview').setup {
        vim.keymap.set('n', '<leader>gv', function()
          if next(require('diffview.lib').views) == nil then
            vim.cmd 'DiffviewOpen'
          else
            vim.cmd 'DiffviewClose'
          end
        end, { desc = 'Git [V]iew Differences' }),
      }
      vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory<CR>', { desc = 'Git [H]istory' })
      vim.keymap.set('n', '<leader>gl', '<cmd>DiffviewLog<CR>', { desc = 'Git [L]ogs' })
      vim.opt.diffopt = {
        'internal',
        'filler',
        'closeoff',
        'context:12',
        'algorithm:histogram',
        'linematch:200',
        'indent-heuristic',
        'iwhite', -- I toggle this one, it doesn't fit all cases.
      }
    end,
  },
}

