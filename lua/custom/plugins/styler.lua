return {
  "folke/styler.nvim",
  config = function()
    require("styler").setup({
      themes = {
        markdown = { colorscheme = "moonfly" },
      },
    })
  end,
}