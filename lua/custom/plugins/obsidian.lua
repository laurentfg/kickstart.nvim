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

-- <leader>o → Obsidian (Oil moved to <C-S-/>)
vim.keymap.set('n', '<leader>on', '<CMD>Obsidian new<CR>', { desc = '[n]ew note' })
vim.keymap.set('n', '<leader>oq', '<CMD>Obsidian quick_switch<CR>', { desc = '[q]uick switch' })
vim.keymap.set('n', '<leader>os', '<CMD>Obsidian search<CR>', { desc = '[s]earch' })
vim.keymap.set('n', '<leader>ob', '<CMD>Obsidian backlinks<CR>', { desc = '[b]acklinks' })
vim.keymap.set('n', '<leader>ot', '<CMD>Obsidian toc<CR>', { desc = '[t]oc (table of contents)' })
vim.keymap.set('n', '<leader>of', '<CMD>Obsidian follow_link<CR>', { desc = '[f]ollow link' })
vim.keymap.set('n', '<leader>ol', '<CMD>Obsidian links<CR>', { desc = '[l]inks in note' })
vim.keymap.set('n', '<leader>od', '<CMD>Obsidian today<CR>', { desc = '[d]aily / today' })
vim.keymap.set('n', '<leader>or', '<CMD>Obsidian rename<CR>', { desc = '[r]ename' })
--vim.keymap.set('n', '<leader>ow', '<CMD>Obsidian workspace<CR>', { desc = '[w]orkspace' })
vim.keymap.set('n', '<leader>op', '<CMD>Obsidian paste_img<CR>', { desc = '[p]aste image' })
vim.keymap.set('n', '<leader>oT', '<CMD>Obsidian template<CR>', { desc = '[T]emplate' })
vim.keymap.set('n', '<leader>oo', '<CMD>Obsidian open<CR>', { desc = '[o]pen app' })

-- Header shortcuts
vim.keymap.set('n', '<leader>o1', 'I# <Esc>', { desc = 'h[1]' })
vim.keymap.set('n', '<leader>o2', 'I## <Esc>', { desc = 'h[2]' })
vim.keymap.set('n', '<leader>o3', 'I### <Esc>', { desc = 'h[3]' })
vim.keymap.set('n', '<leader>o4', 'I#### <Esc>', { desc = 'h[4]' })
vim.keymap.set('n', '<leader>o5', 'I##### <Esc>', { desc = 'h[5]' })
vim.keymap.set('n', '<leader>o6', 'I###### <Esc>', { desc = 'h[6]' })