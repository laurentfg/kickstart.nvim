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
		config = function()
			vim.cmd('colorscheme WinterWood')
		end,
	},
  },
}

