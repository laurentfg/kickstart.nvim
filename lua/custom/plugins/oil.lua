vim.pack.add { 'https://github.com/stevearc/oil.nvim' }
require('oil').setup {
  ---@module 'oil'
  ---@type oil.SetupOpts
  default_file_explorer = false,
}

