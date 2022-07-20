local ls = require("luasnip")
local types = require("luasnip.util.types")

ls.config.set_config{
  history = true,

  updateevents = "TextChanged, TextChangedI",

  enable_autosnippets = true,

  ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
  }
}

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]]) --}}}

--require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/snippets/"})
require("luasnip.loaders.from_vscode").lazy_load()

-- ls.snippets =  {
--     all = {
--       ls.parser.parse_snippet("test", "-- this is whatt hej"),
--     },
--   lua = {
--     ls.parser.parse_snippet("test", "-- this is whatt hej"),
--   },
-- }

vim.keymap.set("n", "<Leader>E", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
