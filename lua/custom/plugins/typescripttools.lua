return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    --cmd = { "typescript-language-server", "--stdio" },
  },
  ft = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  config = function()
    require('typescript-tools').setup {
      on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end,
	  
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        --'vue',
      },
      settings = {
        --tsserver_plugins = {
        --'@vue/typescript-plugin',
        --},
        separate_diagnostic_server = false,
        jsx_close_tag = {
          enable = true,
          filetypes = { 'javascriptreact', 'typescriptreact' },
        },
      },
    }
  end,
}
