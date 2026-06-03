vim.pack.add{"https://github.com/obsidian-nvim/obsidian.nvim"}

require('obsidian').setup{
	--version = "*", -- use latest release, remove to use latest commit
	---@module 'obsidian'
	---@type obsidian.config
	
		legacy_commands = false, -- this will be removed in the next major release
		workspaces = {
			{
				name = "personal",
				path = "~/vaults/personal",
			},
			{
				name = "work",
				path = "~/vaults/work",
			},
		},
		ui = {
			enable = false,
		}
	
}
