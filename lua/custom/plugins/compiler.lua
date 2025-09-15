return {
  {
    { -- This plugin
      'PowerUser64/compiler.nvim',
      branch = 'msbuild',
      name = 'compiler-msbuild',
      cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
      dependencies = { 'stevearc/overseer.nvim', 'nvim-telescope/telescope.nvim' },
      opts = {},
    },
    { -- The task runner we use
      'stevearc/overseer.nvim',
      commit = '6271cab7ccc4ca840faa93f54440ffae3a3918bd',
      cmd = { 'CompilerOpen', 'CompilerToggleResults', 'CompilerRedo' },
      opts = {
        task_list = {
          direction = 'bottom',
          min_height = 25,
          max_height = 25,
          default_detail = 1,
        },
      },
    },
    -- Run the program
    vim.keymap.set('n', '<F9>', function()
      local cwd = vim.fn.getcwd()
      local project_folder = vim.fn.fnamemodify(cwd, ':t')
      local exe_path = '..\\x64\\Debug\\' .. project_folder .. '.exe'
      os.execute('start cmd /C "cd ' .. cwd .. '/' .. project_folder .. ' && ' .. exe_path .. ' && pause"')
    end),

    vim.keymap.set('n', '<leader><F9>', function()
      local cwd = vim.fn.getcwd()
      local project_folder = vim.fn.fnamemodify(cwd, ':t')
      local exe_path = '..\\x64\\Release\\' .. project_folder .. '.exe'
      os.execute('start cmd /C "cd ' .. cwd .. '/' .. project_folder .. ' && ' .. exe_path .. '"')
    end, { desc = 'Execute .exe Release ver.' }),

    --Main button after using F9 once
    vim.keymap.set('n', '<F10>', function()
      local overseer = require 'overseer'
      vim.cmd 'CompilerStop'
      vim.cmd 'CompilerRedo'

      vim.defer_fn(function()
        local tasks = overseer.list_tasks { recent_first = true }
        local task = tasks[1]
        if task then
          task:subscribe('on_complete', function(_, status)
            if status == 'SUCCESS' then
              local cwd = vim.fn.getcwd()
              local project_folder = vim.fn.fnamemodify(cwd, ':t')
              local exe_path = '..\\x64\\Debug\\' .. project_folder .. '.exe'
              os.execute('start cmd /C "cd ' .. cwd .. '\\' .. project_folder .. ' && ' .. exe_path .. ' && pause"')
              vim.cmd 'CompilerToggleResults'
            end
          end)
        else
          vim.notify('❗ Aucune tâche trouvée pour CompilerRedo.', vim.log.levels.ERROR)
        end
      end, 100)
    end, { noremap = true, silent = true }),

    -- Open compiler
    vim.api.nvim_set_keymap('n', '<F11>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true }),

    -- Toggle compiler results
    vim.api.nvim_set_keymap('n', '<F12>', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true }),

    --compile_commands.json must be generated from Visual Studio 2022, Unity or other software
  },
}
