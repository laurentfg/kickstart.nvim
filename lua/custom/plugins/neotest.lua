return {
  {
    'nvim-neotest/neotest',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      --les plugins de tests ici
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-python',
      'mfussenegger/nvim-dap-python',
    },
    opts = {
      adapters = {
        ['neotest-vitest'] = {},
        ['neotest-python'] = {},
      },
    },
    config = function()
      require('neotest').setup {
        summary = {
          open = 'botright vsplit | vertical resize 80',
        },
        adapters = {
          require 'neotest-vitest' {
            -- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
            filter_dir = function(name, rel_path, root)
              return name ~= 'node_modules'
            end,
            test_file_pattern = 'src/.+__tests__/.+%.spec%.ts$',
          },
          require 'neotest-python' { runner = 'unittest' },
        },
      }
    end,

    vim.keymap.set('n', '<leader>tr', "<cmd>lua require('neotest').run.run()<cr>", { desc = '[r]un nearest test' }),

    vim.keymap.set('n', '<leader>tf', "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>", { desc = 'run current [f]ile' }),

    vim.keymap.set('n', '<leader>ta', "<cmd>lua require('neotest').run.run({ suite = true })<cr>", { desc = 'Run [a]ll tests' }),

    vim.keymap.set('n', '<leader>ts', "<cmd>lua require('neotest').run.stop()<cr>", { desc = '[S]top test' }),

    -- vim.keymap.set(
    -- "n",
    -- "<leader>tg",
    -- "<cmd>lua require('neotest').run.stop()<cr>",
    -- {desc = "Dia[g]nostic test"}
    -- ),

    vim.keymap.set('n', '<leader>td', "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", { desc = '[D]ebug nearest test' }),

    vim.keymap.set('n', '<leader>to', "<cmd>lua require('neotest').output.open()<cr>", { desc = 'Show test [o]utput' }),

    vim.keymap.set('n', '<leader>tp', "<cmd>lua require('neotest').output_panel.toggle()<cr>", { desc = 'toggle output [p]anel' }),

    vim.keymap.set('n', '<leader>tv', "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = 'Toggle summary [v]' }),

    vim.keymap.set('n', '<leader>twr', "<cmd>lua require('neotest').run.run({ vitestCommand = 'vitest --watch' })<cr>", { desc = 'Test [R]un Watch' }),

    vim.keymap.set(
      'n',
      '<leader>twf',
      "<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'vitest --watch' })<cr>",
      { desc = 'Test Run Watch [F]ile' }
    ),

    --taken from here: https://gist.github.com/elijahmanor/bac05af95e1536d88a43cbfcb66c1c1d
    vim.keymap.set('n', '<leader>tl', function()
      require('neotest').run.run_last()
    end, { desc = 'Run [l]ast Test' }),
    vim.keymap.set('n', '<leader>tL', function()
      require('neotest').run.run_last { strategy = 'dap' }
    end, { desc = 'Debug [L]ast Test with dap' }),

    --jest?/
    -- vim.keymap.set(
    -- "n",
    -- "<leader>ta",
    -- "<cmd>lua require('neotest').run.run({ jestCommand = 'jest --watch ' })<cr>",
    -- {desc = "Run W[a]tch"}
    -- ),
  },
}

