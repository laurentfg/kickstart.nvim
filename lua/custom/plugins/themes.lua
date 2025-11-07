return {
  {
    { url = 'https://gitlab.com/sxwpb/halfspace.nvim' },

    'rmehri01/onenord.nvim',

    {
      'L-Colombo/oldschool.nvim',
      config = true,
      -- to ovverride palette colors (example):
      -- opts = { white = "#ff07ff"}
    },

    {
      'NLKNguyen/papercolor-theme',
      config = function()
        -- Blank to address startup error
      end,
      init = function()
        vim.opt.termguicolors = true
        --vim.cmd.colorscheme 'PaperColor'
      end,
    },

    {
      'AlexvZyl/nordic.nvim',
      lazy = false,
      --priority = 250,
      --config = function()
      --    require('nordic').load()
      --end
    },

    {
      'projekt0n/github-nvim-theme',
      name = 'github-theme',
      --config = function()
      --vim.cmd('colorscheme github_dark_high_contrast')
      --end,
    },

    'miikanissi/modus-themes.nvim',

    'wtfox/jellybeans.nvim',

    { 'bluz71/vim-moonfly-colors', name = 'moonfly' },

    'rockerBOO/boo-colorscheme-nvim',

    'Mofiqul/vscode.nvim',
    {
      'wtfox/jellybeans.nvim',
      lazy = false,
      opts = {},
    },

    {
      'nvzone/minty',
      cmd = { 'Shades', 'Huefy' },
    },

    {
      'zootedb0t/citruszest.nvim', --,
      --lazy = false,
      --priority = 250,
    },

    'rktjmp/lush.nvim',
    {
      'rockyzhang24/arctic.nvim',
      branch = 'v2',
      dependencies = { 'rktjmp/lush.nvim' },
    },

    {
      'adibhanna/forest-night.nvim',
      --priority = 1000,
      --config = function()
      --vim.cmd([[colorscheme forest-night]])
      --end,
    },

    { 'jacoborus/tender.vim' },

    {
      --dir = "/prog/WinterWood",
      vim.fn.isdirectory '/prog/WinterWood' == 1 and { dir = '/prog/WinterWood' } or nil,
    },

    {
      'catppuccin/nvim',
      name = 'catppuccin',
      priority = 1000,
      config = function()
        require('catppuccin').setup {
          color_overrides = {
            all = {},
            latte = {},
            frappe = {},
            macchiato = {
              rosewater = '#ADE490', --light green, "#f5e0dc",
              flamingo = '#f2cdcd', --use "#f92672" instead?
              pink = '#D193CC', --"#f5c2e7",
              mauve = '#9564F1', --"#cba6f7",
              red = '#D16969', --"#f38ba8",
              maroon = '#FEA54C', --"#eba0ac",
              peach = '#fab387',
              yellow = '#FCFCAA', --"#f9e2af",
              green = '#6A9955', --"#a6e3a1",
              teal = '#00E5C6', --"#94e2d5",
              sky = '#89dceb', --?"#EFEFF5"?
              sapphire = '#74c7ec',
              blue = '#0CA5F2', --"#89b4fa",
              lavender = '#CCA3FE', --"#b4befe",

              text = '#ebebeb', --"#cdd6f4",
              subtext1 = '#bac2de',
              subtext0 = '#a6adc8',
              overlay2 = '#9399b2',
              overlay1 = '#7f849c',
              overlay0 = '#6c7086',
              surface2 = '#585b70',
              surface1 = '#45475a',
              surface0 = '#313244',

              base = '#070507', --"#1e1e2e",
              mantle = '#101015', --"#181825",
              crust = '#05050b', --"#11111b",
            },
            mocha = {},
          },
          highlight_overrides = {
            macchiato = function(macchiato)
              return {
                ['@punctuation.delimiter'] = { fg = macchiato.text },
                ['@punctuation.bracket'] = { fg = macchiato.text },
                ['@variable'] = { fg = macchiato.text },
                ['@lsp.mod.local.typescriptreact'] = { fg = macchiato.text },
				Operator = ({ fg = macchiato.text }),

                LspReferenceText = { bg = macchiato.surface0 },
                LspReferenceRead = { bg = macchiato.surface0 },
                LspReferenceWrite = { bg = macchiato.surface0 },
                IlluminatedWordText = { bg = macchiato.surface0 },
                IlluminatedWordRead = { bg = macchiato.surface0 },
                IlluminatedWordWrite = { bg = macchiato.surface0 },

                Comment = { fg = macchiato.green },

                String = { fg = macchiato.maroon },

                Number = { fg = macchiato.rosewater },

                LineNrAbove = { fg = macchiato.overlay0 },
                --LineNr = { fg = macchiato.rosewater },
                LineNrBelow = { fg = macchiato.overlay0 },

                Methods = { fg = macchiato.yellow },
                Function = { fg = macchiato.yellow },

                ['@variable.parameter'] = { fg = macchiato.overlay2 },

                DiagnosticHint = { fg = macchiato.subtext0 },

                --["@keyword.import"] = { fg = macchiato.pink },
                ["@keyword.import"] = { fg = macchiato.pink },
                ["@keyword.import.rust"] = { fg = macchiato.pink },
                ["@keyword.import.java"] = { fg = macchiato.pink },
                ["@keyword.import.c"] = { fg = macchiato.pink },
                ["@keyword.import.cpp"] = { fg = macchiato.pink },
                Include = { fg = macchiato.pink },
                ['@keyword.export'] = { fg = macchiato.pink }, --for React Native

                Type = { fg = macchiato.blue },
                Keyword = { fg = macchiato.blue },
                ['type.builtin'] = { fg = macchiato.blue },
                ['@type.builtin'] = { fg = macchiato.blue },
                --['@variable.builtin'] = { fg = macchiato.blue },
                ['@keyword.type'] = { fg = macchiato.blue },
                ['@keyword.function'] = { fg = macchiato.blue }, --for React Native
                ['@lsp.type.enum'] = { fg = macchiato.blue },
                ['@lsp.typemod.class.defaultLibrary'] = { fg = macchiato.blue },
                Boolean = { fg = macchiato.blue },

                ['@module'] = { fg = macchiato.teal },
                ['@type'] = { fg = macchiato.teal },
                ['@attribute'] = { fg = macchiato.teal },

                Repeat = { fg = macchiato.pink },
                Conditional = { fg = macchiato.pink },
                ['@keyword.return'] = { fg = macchiato.pink },
                PreProc = { fg = macchiato.pink },

                ['@lsp.typemod.variable.readonly'] = { fg = macchiato.mauve },
                ['@lsp.typemod.property.readonly'] = { fg = macchiato.mauve },
                ['@lsp.type.enumMember'] = { fg = macchiato.mauve },
              }
            end,
          },
        }
        vim.cmd 'colorscheme catppuccin-macchiato'
      end,
    },
  },
}
