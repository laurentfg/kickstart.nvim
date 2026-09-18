vim.pack.add { 'https://github.com/folke/styler.nvim' }

require('styler').setup {
  themes = {
    markdown = { colorscheme = 'moonfly' },
  },
}

-- Markdown-only: moonfly theme (above) + treesitter folds for headings
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
  end,
})
