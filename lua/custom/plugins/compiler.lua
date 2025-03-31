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
    -- Run the program (simulate VS behavior)
    vim.keymap.set('n', '<F9>', function()
      local cwd = vim.fn.getcwd()
      local project_folder = vim.fn.fnamemodify(cwd, ':t')
      local exe_path = '..\\x64\\Debug\\' .. project_folder .. '.exe'
      os.execute('start cmd /C "cd ' .. cwd .. '/' .. project_folder .. ' && ' .. exe_path .. ' && pause"')
	  vim.cmd('CompilerToggleResults')
    end),
	vim.keymap.set('n', '<c-F9>', function()
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
	  vim.cmd('CompilerToggleResults')
    end, { desc = 'Execute .exe Release ver.' }),

    -- Redo last selected option
    vim.api.nvim_set_keymap(
      'n',
      '<F10>',
      '<cmd>CompilerStop<cr>' -- (Optional, to dispose all tasks before redo)
        .. '<cmd>CompilerRedo<cr>',
      { noremap = true, silent = true }
    ),

    -- Open compiler
    vim.api.nvim_set_keymap('n', '<F11>', '<cmd>CompilerOpen<cr>', { noremap = true, silent = true }),

    -- Toggle compiler results
    vim.api.nvim_set_keymap('n', '<F12>', '<cmd>CompilerToggleResults<cr>', { noremap = true, silent = true }),
	
	--Make compile.commands.json
    --vim.api.nvim_set_keymap('n', '<c-F11>', '<CMD>make -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -B build && cp build/compile_commands.json .<CR>', { noremap = true, silent = true }),
	
	--local function generate_compile_commands()
	--  local cmd = 'powershell -Command "& {clang-build.ps1}"'
	--  os.execute(cmd)
	--  print("✅ compile_commands.json généré avec succès !")
	--end

	--vim.api.nvim_create_user_command("GenerateCompileCommands", generate_compile_commands, {}),

	--requires 'leosmaia21/gcompilecommands.nvim'
	--vim.keymap.set("n", "<C-F11>", '<CMD>Gcompilecommands<CR>',{ desc = "Générer compile_commands.json" })
	
  },
}

