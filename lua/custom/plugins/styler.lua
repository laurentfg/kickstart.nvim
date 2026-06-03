vim.pack.add{"https://github.com/folke/styler.nvim"}

require("styler").setup({
  themes = {
    markdown = { colorscheme = "moonfly" },
  },
})