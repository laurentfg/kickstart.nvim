vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/jay-babu/mason-nvim-dap.nvim',
}

keys = {
  -- Basic debugging keymaps, feel free to change to your liking!
  {
    '<F5>',
    function()
      require('dap').continue()
    end,
    desc = 'Debug: Start/Continue',
  },
  {
    '<F1>',
    function()
      require('dap').step_into()
    end,
    desc = 'Debug: Step Into',
  },
  {
    '<F2>',
    function()
      require('dap').step_over()
    end,
    desc = 'Debug: Step Over',
  },
  {
    '<F3>',
    function()
      require('dap').step_out()
    end,
    desc = 'Debug: Step Out',
  },
  {
    '<F4>',
    function()
      require('dap').step_back()
    end,
    desc = 'Debug: Step back',
  },
  {
    '<leader>b',
    function()
      require('dap').toggle_breakpoint()
    end,
    desc = 'Debug: Toggle Breakpoint',
  },
  {
    '<leader>B',
    function()
      require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end,
    desc = 'Debug: Set Breakpoint',
  },

  {
    '<F7>',
    function()
      require('dapui').toggle()
    end,
    desc = 'Debug: See last session result.',
  },
}

local dap = require 'dap'
local dapui = require 'dapui'

require('mason-nvim-dap').setup {
  automatic_installation = true,

  handlers = {},

  ensure_installed = {
    'codelldb',
  },
}

dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
}

--kickstart defaults
dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

vim.keymap.set('n', '<leader>?', function()
  require('dapui').eval(nil, { enter = true })
end, { desc = 'Expand values during debug [?]' })

vim.keymap.set('n', '<space>gb', dap.run_to_cursor, { desc = 'run until cursor for [b]reakpoint' })

dap.adapters.codelldb = {
  type = 'executable',
  command = 'codelldb',

  -- On windows you may have to uncomment this:
  detached = false,
}

dap.configurations.cpp = {
  {
    name = 'Launch file',
    type = 'codelldb',
    request = 'launch',
    program = function()
      local cwd = vim.fn.getcwd()
      local basic_path = vim.fn.fnamemodify(cwd, ':h')
      local project_folder = vim.fn.fnamemodify(cwd, ':t')
      return basic_path .. '\\' .. project_folder .. '\\x64\\Debug\\' .. project_folder .. '.exe'
    end,
    cwd = function()
      local cwd = vim.fn.getcwd()
      local project_folder = vim.fn.fnamemodify(cwd, ':t')
      return cwd .. '\\' .. project_folder
    end,
  },
}
