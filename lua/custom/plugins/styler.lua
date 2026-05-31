return {
  --{ 'bluz71/vim-moonfly-colors', name = 'moonfly' },
  "folke/styler.nvim",
  config = function()
    require("styler").setup({
      themes = {
        markdown = { colorscheme = "moonfly" },
      },
    })
  end,
}