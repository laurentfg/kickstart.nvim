vim.lsp.start({
  name = "gdshader",
  cmd = { "gdshader-lsp" }, -- in PATH
  root_dir = vim.fs.dirname(vim.fs.find({ "project.godot" }, { upward = true })[1]), --validate that it's a project
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})