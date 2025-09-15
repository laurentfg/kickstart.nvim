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
		--dir = "/prog/WinterWood",
vim.fn.isdirectory("/prog/WinterWood") == 1 and { dir = "/prog/WinterWood" } or nil,
	},
		--config = function()
		--	if vim.fn.isdirectory("/prog/WinterWood") == 0 then
		--	table.insert(plugins, {
		--		dir = "/prog/WinterWood",
		--	})
		--	end
		--end,
		
	
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
						teal      = "#00E5C6",--"#94e2d5",
						sky       = "#89dceb",--?"#EFEFF5"?
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
							Function = { fg = macchiato.yellow },
							["@variable.parameter"] = { fg = macchiato.overlay1},
							["@variable"] = { fg = macchiato.sky },
							["@type"] = { fg = macchiato.teal},
							["type.builtin"] = { fg = macchiato.blue },
							
							--["@keyword.import"] = { fg = macchiato.pink },     
							--["@keyword.import.cpp"] = { fg = macchiato.pink }, 
							--["@keyword.import.rust"] = { fg = macchiato.pink },
							--["@keyword.import.java"] = { fg = macchiato.pink },
							--Include = { fg = macchiato.pink },
							--PreProc = { fg = macchiato.pink },
							
							Type = { fg = macchiato.blue },
							["@type.builtin"] = { fg = macchiato.blue },
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

