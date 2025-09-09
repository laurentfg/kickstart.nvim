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
      'zootedb0t/citruszest.nvim'--,
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
	  "adibhanna/forest-night.nvim",
	  --priority = 1000,
	  --config = function()
		--vim.cmd([[colorscheme forest-night]])
	  --end,
	},
	
	{'jacoborus/tender.vim'},
	
	{
		dir = "/prog/WinterWood",
	},
	
	{ 
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup {
				color_overrides = {
					all = {
					},
					--example
					latte = {
					},
					frappe = {},
					macchiato = {
						rosewater = "#f5e0dc",
						flamingo  = "#f2cdcd",--use "#f92672" instead?
						pink      = "#D193CC",--"#f5c2e7",
						mauve     = "#9564F1",--"#cba6f7",
						red       = "#D16969",--"#f38ba8",
						maroon    = "#FEA54C",--"#eba0ac",
						peach     = "#fab387",
						yellow    = "#FCFCAA",--"#f9e2af",
						green     = "#6A9955",--"#a6e3a1",
						teal      = "#EFEFF5",--"#94e2d5",
						sky       = "#89dceb",
						sapphire  = "#74c7ec",
						blue      = "#0CA5F2",--"#89b4fa",
						lavender  = "#CCA3FE",--"#b4befe",
						
						text      = "#cccccc",--"#cdd6f4",
						subtext1  = "#bac2de",
						subtext0  = "#a6adc8",
						overlay2  = "#9399b2",
						overlay1  = "#7f849c",
						overlay0  = "#6c7086",
						surface2  = "#585b70",
						surface1  = "#45475a",--"#45475a",
						surface0  = "#313244",
						
						base      = "#0f0b0f",--"#1e1e2e",
						mantle    = "#101015",--"#181825",
						crust     = "#05050b",--"#11111b",
					},
					mocha = {},
				},
				highlight_overrides = {
					macchiato = function(macchiato)
						return {
							Comment = { fg = macchiato.green },
							String = { fg = macchiato.maroon },
							Methods = { fg = macchiato.yellow },
							Functions = { fg = macchiato.yellow },
							["@variable.parameter"] = { fg = macchiato.overlay1},
							["@variable"] = { fg = macchiato.teal },
							["@type"] = { fg = macchiato.teal},
						}
					end,
				}
			}
			vim.cmd('colorscheme catppuccin-macchiato')
			--vim.cmd.colorscheme "catppuccin-mocha"
		end,
	},

  }
}

