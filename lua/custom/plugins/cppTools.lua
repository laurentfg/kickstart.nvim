vim.pack.add { 'https://github.com/Badhi/nvim-treesitter-cpp-tools' }

require('nt-cpp-tools').setup {
  preview = {
    quit = 'q', -- optional keymapping for quit preview
    accept = '<tab>', -- optional keymapping for accept preview
  },
  header_extension = 'h', -- optional
  source_extension = 'cpp', -- optional
  custom_define_class_function_commands = { -- optional
    TSCppImplWrite = {
      output_handle = require('nt-cpp-tools.output_handlers').get_add_to_cpp(),
    },
    --[[
				<your impl function custom command name> = {
					output_handle = function (str, context) 
						-- string contains the class implementation
						-- do whatever you want to do with it
					end
				}
				]]
  },
}
-- End configuration
Config = true, vim.keymap.set({ 'n' }, '<leader>dd', '<cmd>TSCppDefineClassFunc<CR>', { desc = 'C++ [d]efine functions' })
vim.keymap.set({ 'v' }, '<leader>dd', ":<C-U>'<,'>TSCppDefineClassFunc<CR>", { desc = 'C++ [d]efine highlighted functions' })
--disabled because they doesn't work on Windows?
--vim.keymap.set("n", "<leader>cm", "<cmd>TSCppMakeConcreteClass<CR>", {desc = "C++ [m]ake concrete class"})
--vim.keymap.set("n", "<leader>dt", "<cmd>TSCppRuleOf3<CR>", {desc = "C++ rule of [t]hree"})
--vim.keymap.set("n", "<leader>cf", "<cmd>TSCppRuleOf5<CR>", {desc = "C++ rule of [f]ive"})
