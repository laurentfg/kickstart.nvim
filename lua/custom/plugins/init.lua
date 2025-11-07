-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

return {
  {
    vim.filetype.add {
      extension = {
        frag = 'glsl',
        vert = 'glsl',
        geom = 'glsl',
        comp = 'glsl',
      },
    },

    --hate when that happens when going too fast, so here is a good enough fix
    vim.api.nvim_create_user_command('W', 'w', {}),
    vim.api.nvim_create_user_command('Wq', 'wq', {}),
    vim.api.nvim_create_user_command('Wa', 'wa', {}),
    vim.api.nvim_create_user_command('Wqa', 'wqa', {}),
    vim.api.nvim_create_user_command('Q', 'q', {}),
    vim.api.nvim_create_user_command('Qa', 'qa', {}),

    vim.keymap.set('n', '<leader>z', ':Telescope colorscheme<CR>', { desc = 'Select Colorscheme' }),
    vim.keymap.set('n', '<leader>Z', '<cmd>!chmod +x %<CR>', { desc = 'make the file executable (Linux)' }),

    --taken from Theprimeagen
    --slide the selected through the text like a box
    vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv"),
    vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv"),

    --cursor stays
    vim.keymap.set('n', 'J', 'mzJ`z'),
    vim.keymap.set('n', '<C-u>', '<C-u>zz'),
    vim.keymap.set('n', '<C-d>', '<C-d>zz'),
    vim.keymap.set('n', 'n', 'nzzzv'),
    vim.keymap.set('n', 'N', 'Nzzzv'),

    --cursor moves horizontally
    vim.keymap.set('n', '<M-a>', 'zH'),
    vim.keymap.set('n', '<M-d>', 'zL'),
    --screen move without cursor
    vim.keymap.set('n', '<M-w>', 'zb'),
    vim.keymap.set('n', '<M-s>', 'zt'),

    --harpoon has the CTRL+hjkl, so the window move is set to ALT
    --vim.keymap.set('n', '<M-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' }),
    --vim.keymap.set('n', '<M-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' }),
    --vim.keymap.set('n', '<M-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' }),
    --vim.keymap.set('n', '<M-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' }),

    --obsolete since capital P works now for that
    --vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Paste without replacing buffer' }),

    --put the yank in the OS register
    vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'yank to OS Register' }),
    vim.keymap.set('n', '<leader>Y', 'ggVGy', { desc = '[Y]ank whole document' }),

    --movement stays centered in quickfix
    vim.keymap.set('n', '<M-n>', '<cmd>cnext<CR>zz'),
    vim.keymap.set('n', '<M-p>', '<cmd>cprev<CR>zz'),
    vim.keymap.set('n', '<leader>n', '<cmd>lnext<CR>zz', { desc = 'Quickfix [n]ext' }),
    vim.keymap.set('n', '<leader>p', '<cmd>lprev<CR>zz', { desc = 'Quickfix [p]revious' }),

    --My keyboard layout can't C-^ , so I'm using this alternative
    vim.keymap.set('n', 'Q', '<C-^>'),
    vim.keymap.set('n', '<M-q>', '<cmd>LspClangdSwitchSourceHeader<CR>', { noremap = true, silent = true }),

    --for Oil.nvim
    vim.keymap.set('n', '<leader>o', '<CMD>Oil<CR>', { desc = '[O]pen parent directory' }),

    --enter a manual command to apply on visual blocks/v-lines
    vim.keymap.set('x', '<leader>n', ':norm ', { desc = '[n]ormal cmd on highlight' }),

    --vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>"),

    vim.keymap.set('n', '<M-Left>', '<cmd>vertical resize -5<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-Right>', '<cmd>vertical resize +5<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-Up>', '<cmd>resize +5<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-Down>', '<cmd>resize -5<CR>', { noremap = true, silent = true }),

    --all 3 made by ChatGPT
    --equivalent to CTRL+w to the right
    vim.keymap.set('i', '<C-Del>', function()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line = vim.api.nvim_get_current_line()

      local _, finish = line:find('%s*%w*', col + 1)
      if finish == nil then
        return
      end

      local new_line = line:sub(1, col) .. line:sub(finish + 1)
      vim.api.nvim_set_current_line(new_line)
    end, { desc = 'Delete word to the right', noremap = true }),

    --delete backward find uppercase
    vim.keymap.set('i', '<M-w>', function()
      local col = vim.fn.col '.'
      if col <= 1 then
        return
      end

      local line = vim.fn.getline '.'
      local start = col - 1
      while start > 0 and not line:sub(start, start):match '[A-Z]' do
        start = start - 1
      end

      local n = (start == 0) and col - 1 or col - start
      local bs = vim.api.nvim_replace_termcodes('<BS>', true, false, true)
      vim.api.nvim_feedkeys(bs:rep(n), 'n', true)
    end, { desc = 'Delete to previous uppercase letter', noremap = true }),

    --delete forward find uppercase
    vim.keymap.set('i', '<M-Del>', function()
      local col = vim.fn.col '.'
      local line = vim.fn.getline '.'
      local len = #line
      if col > len then
        return
      end

      local stop = col + 1
      while stop <= len and not line:sub(stop, stop):match '[A-Z]' do
        stop = stop + 1
      end

      local n = (stop > len) and (len - col + 1) or (stop - col)
      local del = vim.api.nvim_replace_termcodes('<Del>', true, false, true)
      vim.api.nvim_feedkeys(del:rep(n), 'n', true)
    end, { desc = 'Delete to next uppercase letter', noremap = true }),

    --Imitate regular IDE's shortcut to quickly comment a line. Basic fix for // only
    --2nd one is used with my keyboard layout in Neovim, but first one is the intended shortcut
    vim.keymap.set('n', '<C-/>', 'mzI//<Esc>`z', { noremap = false, silent = true }),
    vim.keymap.set('n', '<C-_>', 'mzI//<Esc>`z', { noremap = false, silent = true }),

    --lazy shortcut, intended when no more lines will be edited
    vim.keymap.set('i', '<M-;>', '<esc>A;<esc>'),

    --Imitate IDEs like Intellij
    vim.keymap.set('i', '<M-[>', function()
      vim.api.nvim_input '<esc>A{<Enter>'
    end, { noremap = true }),

    --rename from a Linux path to a Windows path
    vim.keymap.set('n', '<leader>pr', function()
      local line = vim.api.nvim_get_current_line()
      -- Content match in quotation marks after an opening parenthesis
      local new_line = line:gsub('"(.-)"', function(path)
        if path:sub(1, 2) == './' then
          path = path:sub(3)
        end
        path = path:gsub('/', '\\\\')
        return '"' .. path .. '"'
      end, 1)

      vim.api.nvim_set_current_line(new_line)
    end, { desc = '[r]ename path to Windows version' }),

    vim.keymap.set('n', '<Leader>N', ":let @+ = expand('%:t')<cr>", { desc = 'copy [N]ame file to clipboard' }),

    -- <leader>X : envoie avec le même nom de fichier
    vim.keymap.set('n', '<leader>x', function()
      local file = vim.fn.expand '%:p'
      local filename = vim.fn.expand '%:t'
      local project_root = vim.fn.getcwd()
      local cmd_file = project_root .. '/commande.txt'

      if vim.fn.filereadable(cmd_file) == 0 then
        print 'Fichier commande.txt introuvable'
        return
      end

      local lines = vim.fn.readfile(cmd_file)
      if #lines < 2 then
        print 'commande.txt doit avoir au moins 2 lignes (clé et destination)'
        return
      end

      local key = vim.fn.trim(lines[1]) -- première ligne = clé + options
      local dest = vim.fn.trim(lines[2]) -- deuxième ligne = destination

      -- Construire la commande scp
      local final_cmd = string.format('%s %s %s%s', key, file, dest, filename)

      -- Exécuter
      local output = vim.fn.system(final_cmd)

      if vim.v.shell_error ~= 0 then
        vim.notify('Erreur SCP : ' .. output, vim.log.levels.ERROR)
      else
        vim.notify('Envoyé : ' .. file .. ' → ' .. dest .. filename, vim.log.levels.INFO)
      end
    end, { desc = 'SCP fichier courant via commande.txt' }),

    vim.api.nvim_create_user_command('CsReload', function()
      vim.lsp.buf.execute_command { command = 'omnisharp/reloadProject' }
    end, {}),
  },
}
