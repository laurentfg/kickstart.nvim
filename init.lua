do
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  --disabled because of Windows' terminal having priority
  --vim.g.have_nerd_font = false

  --Neovide
  if vim.g.neovide then
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        vim.o.columns = 140
        vim.o.lines = 40
      end,
    })
    vim.g.neovide_remember_window_size = true

    -- animations off (source: FAQ)
    vim.g.neovide_position_animation_length = 0
    vim.g.neovide_cursor_animation_length = 0.00
    vim.g.neovide_cursor_trail_size = 0
    vim.g.neovide_cursor_animate_in_insert_mode = false
    vim.g.neovide_cursor_animate_command_line = false
    vim.g.neovide_scroll_animation_far_lines = 0
    vim.g.neovide_scroll_animation_length = 0.00

    -- change scale at Runtime (source: FAQ)
    vim.g.neovide_scale_factor = 1.0

    local change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end

    vim.keymap.set('n', '<C-=>', function()
      change_scale_factor(1.25)
    end)

    vim.keymap.set('n', '<C-->', function()
      change_scale_factor(1 / 1.25)
    end)

    vim.keymap.set('n', '<C-0>', function()
      vim.g.neovide_scale_factor = 1.0
    end)

    --font
    vim.o.guifont = 'Hack Nerd Font Mono:h14'
    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_left = 0
    vim.g.neovide_padding_right = 0

    vim.opt.linespace = -1
  end

  -- compatibility Win10 LTSC
  if vim.fn.has 'win32' == 1 then
    local termfeatures = vim.g.termfeatures or {}
    termfeatures.osc52 = false
    vim.g.termfeatures = termfeatures
  end

  -- remove start message
  vim.cmd 'set shortmess+=I'

  -- configure folds
  --vim.cmd("set foldcolumn=1")
  vim.cmd 'set foldmethod=indent'
  vim.opt.foldlevelstart = 99

  -- [[ Setting options ]]
  -- See `:help vim.opt`

  vim.opt.tabstop = 4
  vim.opt.shiftwidth = 4
  vim.opt.softtabstop = 4
  vim.opt.expandtab = true

  vim.opt.colorcolumn = '120'
  vim.opt.textwidth = 120
  vim.opt.linebreak = true

  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    callback = function()
      vim.opt_local.textwidth = 0
    end,
  })

  vim.opt.number = true
  vim.opt.relativenumber = true

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.opt.mouse = 'a'

  vim.opt.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function()
    vim.opt.clipboard = 'unnamedplus'
  end)

  vim.opt.breakindent = true

  vim.opt.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.opt.ignorecase = true
  vim.opt.smartcase = true

  -- Keep signcolumn on by default
  vim.opt.signcolumn = 'yes'

  -- Decrease update time
  vim.opt.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.opt.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.opt.splitright = true
  vim.opt.splitbelow = true

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  vim.opt.list = true
  vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

  -- Preview substitutions live, as you type!
  vim.opt.inccommand = 'split'

  -- Show which line your cursor is on
  vim.opt.cursorline = true

  -- Minimal number of screen lines to keep above and below the cursor.
  vim.opt.scrolloff = 10

  -- search highlight adapts to the current search
  vim.opt.hlsearch = false
  vim.opt.incsearch = true

  vim.opt.conceallevel = 0

  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
  --vim.keymap.set("i", "jj", "<esc>")

  --function example:
  --vim.keymap.set("i", "jk", function() print("hello") end)

  -- Diagnostic keymaps
  vim.keymap.set('n', '<c-e>', vim.diagnostic.open_float, { desc = 'Show Diagnostic [E]rror messages' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  --easier escape terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  --highlight on yank
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.hl.on_yank()
    end,
  })

  -- Prevents the non-breaking space when writing right ALT + space (can be very bad when unnoticed)
  vim.api.nvim_create_autocmd('InsertCharPre', {
    callback = function()
      if vim.v.char == '\u{00A0}' then
        vim.v.char = ''
      end
    end,
  })

  --For Laravel TODO: valider
  vim.filetype.add {
    pattern = {
      ['.*%.blade%.php'] = 'blade',
    },
  }
  vim.treesitter.language.register('html', 'blade')
end

--beginning vim.pack
do
  --autocommand
  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then
        output = 'No output from build command.'
      end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  --see vim.pack-events
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then
        return
      end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then
          run_build(name, { 'make', 'install_jsregexp' }, ev.data.path)
        end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then
          vim.cmd.packadd 'nvim-treesitter'
        end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo)
  return 'https://github.com/' .. repo
end

-- SECTION 3: UI / CORE UX PLUGINS

do
  --example:
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  if vim.g.have_nerd_font then
    vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }
  end

  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  require('gitsigns').setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
  }

  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.opt.timeoutlen
      delay = 600,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle/[T]est' },
        { '<leader>r', group = '[R]est HTTP' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        --lolo: added these lines
        { '<leader>g', group = '[G]it menu' },
        { '<leader>p', group = '[P]roject' },
        --{ '<leader>pw', group = '[P]roject [w]ord' },
        --{ '<leader>pW', group = '[P]roject [W]ORD' },
        { '<leader>tw', group = '[T]est [w]atch' },
        { 'gr', group = 'LSP Actions [r]', mode = { 'n' } },
      },
    },
  }

  --COLORSCHEMES TODO:

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- MINI https://github.com/nvim-mini/mini.nvim
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  require('mini.surround').setup()

  local statusline = require 'mini.statusline'
  --statusline.setup { use_icons = vim.g.have_nerd_font }
  statusline.setup { use_icons = false }
  statusline.section_location = function()
    return '%2l:%-2v'
  end
end

-- SECTION 4: SEACH & NAVIGATION
do
  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then
    table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim')
  end

  vim.pack.add(telescope_plugins)

  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = '[O]pen Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open [W]orkspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = 'Goto [t]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set('n', '<leader>s/', function()
    builtin.live_grep {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
    }
  end, { desc = '[S]earch [/] in Open Files' })

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function()
    builtin.find_files { cwd = vim.fn.stdpath 'config' }
  end, { desc = '[S]earch [N]eovim files' })
end

-- SECTION 5: LSP
do
  --vim.pack.add { gh 'j-hui/fidget.nvim' }
  --require('fidget').setup {}

  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, 'Goto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, 'Goto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
        end, 'Toggle Inlay [h]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers =
    {
      clangd = {},
      cpplint = {},
      cssls = {},
      jdtls = {},

      lua_ls = {
        on_init = function(client)
          client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT',
              path = { 'lua/?.lua', 'lua/?/init.lua' },
            },
            workspace = {
              checkThirdParty = false,
              -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
              --  See https://github.com/neovim/nvim-lspconfig/issues/3189
              library = vim.tbl_extend('force', vim.api.nvim_get_runtime_file('', true), {
                '${3rd}/luv/library',
                '${3rd}/busted/library',
              }),
            },
          })
        end,
        ---@type lspconfig.settings.lua_ls
        settings = {
          Lua = {
            format = { enable = false }, -- Disable formatting (formatting is done by stylua)
          },
        },
      },

      -- Vue (Laravel)
      -- npm install -g @vue/language-server
      -- npm install -g @vue/typescript-plugin
      vue_ls = {},
      ts_ls = {},

      --glslx = {
      --	cmd = {"glslx", "--stdio" },
      --	filetypes = { "glsl", "vert", "frag" },
      --	root_dir = function(fname)
      --		return vim.fn.getcwd()
      --	end,
      --},
      glsl_analyzer = {
        filetypes = { 'glsl' },
      },

      omnisharp = {
        cmd = {
          vim.fn.stdpath 'data' .. '/mason/packages/omnisharp/libexec/OmniSharp.exe',
          --cmd = {"omnisharp",
          '--languageserver',
          '--hostPID',
          tostring(vim.fn.getpid()),
        },
        enable_editorconfig_support = true,
        enable_roslyn_analyzers = true,
        organize_imports_on_format = true,
        enable_import_completion = true,
        sdk_include_prereleases = true,
        capabilities = capabilities,
      },
      --omnisharp-mono = {},

      --python
      pyright = {},
      --pylsp = {},

      --Godot
      gdtoolkit = {},
      --gdscript = {},

      --Laravel
      intelephense = {
        filetypes = { 'php', 'blade' },
      },
      html = {
        filetypes = { 'html', 'blade' },
        init_options = {
          configurationSection = { 'html', 'css', 'javascript' },
          embeddedLanguages = {
            css = true,
            javascript = true,
          },
          provideFormatter = true,
        },
      },

      tailwindcss = {
        filetypes = { 'html', 'blade' },
        init_options = {
          userLanguages = {
            blade = 'html',
          },
        },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              blade = 'html',
            },
          },
        },
      },
    }, vim.pack.add {
      gh 'neovim/nvim-lspconfig',
      gh 'mason-org/mason.nvim',
      gh 'mason-org/mason-lspconfig.nvim',
      gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
    }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

--SECTION 6: FORMATTING
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      cpp = { 'clang-format' },
      c = { 'clang-format' },
      -- if Mason version doesn't work, use the one installed in $PATH installed by dotnet tool
      cs = { 'csharpier', stop_after_first = true },
      h = { 'clang-format' },
      glsl = { 'clang-format' },
      lua = { 'stylua' },
      vue = { 'vue-language-server', stop_after_first = true },
      javascript = { 'prettier', stop_after_first = true },
      typescript = { 'prettier', stop_after_first = true },
      typescriptreact = { 'prettier', stop_after_first = true },
      gdscript = { 'gdformat' },
      gdshader = { 'clang-format' },
      php = { 'pint' },
      --php = { 'pint', 'php_cs_fixer', stop_after_first = true },

      -- Conform can also run multiple formatters sequentially
      python = { 'isort', 'black' },
      markdown = { 'prettier' },
      blade = { 'blade-formatter' },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
    },
    formatters = {
      prettier = {
        prepend_args = {
          --"--config", vim.fn.expand("~/.prettierrc")
          '--tab-width',
          '4',
          '--use-tabs',
          'false',
        },
      },
      csharpier = {
        command = 'csharpier',
        args = { 'format', '--write-stdout' },
        stdin = true,
      },

      --Godot
      gdformat = {
        command = 'gdformat',
        args = { '-' },
        stdin = true,
      },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
    require('conform').format { async = true }
  end, { desc = '[F]ormat buffer' })
end

-- SECTION 7: autocomplete & snippets
do
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      preset = 'default',
      ['<C-o>'] = {
        function(cmp)
          cmp.mapping.confirm { select = true }
        end,
      },
      ['<C-space>'] = {
        function(cmp)
          cmp.mapping.complete {}
        end,
      },
      ['<M-Space>'] = {
        function(cmp)
          cmp.mapping.complete {}
        end,
      },
    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
    },
    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

-- SECTION 8: TREESITTER
do
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }
  local parsers = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'glsl' }
  require('nvim-treesitter').install(parsers)
  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then
      return
    end
    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    -- vim.wo.foldmethod = 'expr'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function()
          treesitter_try_attach(buf, language)
        end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

--SECTION 9: Optional
do
  
  require 'kickstart.plugins.debug'
  require 'kickstart.plugins.autopairs'
  require 'kickstart.plugins.neo-tree'
  require 'kickstart.plugins.gitsigns' -- adds gitsigns recommend keymaps

  vim.pack.add { gh 'tpope/vim-sleuth' } -- Detect tabstop and shiftwidth automatically

  vim.pack.add { gh 'Aasim-A/scrollEOF.nvim' }
  require('scrollEOF').setup {
    event = { 'CursorMoved', 'WinScrolled' },
    opts = {},
  }

  vim.pack.add { gh 'fabridamicelli/cronex.nvim' }

  vim.pack.add { gh 'mfussenegger/nvim-jdtls' }

  --maybe: lazy = true
  vim.pack.add { gh 'nvzone/volt' }
  
  vim.pack.add { gh 'junegunn/vim-easy-align' }
  vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { desc = 'EasyAlign text' })
  vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { desc = 'EasyAlign text' })

  vim.pack.add { gh 'teatek/gdscript-extended-lsp.nvim' }
  require('gdscript-extended-lsp').setup {
    opts = { view_type = 'floating', picker = 'telescope' },
  }

  vim.pack.add { gh 'QuickGD/quickgd.nvim' }
  require('quickgd').setup {
    ft = { 'gdshader', 'gdshaderinc' },
    cmd = { 'GodotRun', 'GodotRunLast', 'GodotStart' },
    -- Use opts if passing in settings else use config
    init = function()
      vim.filetype.add {
        extension = {
          gdshaderinc = 'gdshaderinc',
        },
      }
    end,
    config = true,
    opts = {},
  }
  
  require 'custom.plugins'
  
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
