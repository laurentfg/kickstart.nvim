vim.pack.add { 'https://github.com/obsidian-nvim/obsidian.nvim' }

require('obsidian').setup {
  --version = "*", -- use latest release, remove to use latest commit
  ---@module 'obsidian'
  ---@type obsidian.config

  legacy_commands = false, -- this will be removed in the next major release
  workspaces = {
    {
      name = 'personal',
      path = '~/vaults/personal/gameproject',
    },
    {
      name = 'work',
      path = '~/vaults/work',
    },
  },
  
  -- Readable filenames like Obsidian, not timestamps
  note_id_func = require('obsidian.builtin').title_id,
  -- New notes next to the current file (good for a folder tree)
  new_notes_location = 'current_dir',
  
  ui = {
    enable = false,
  },
}
