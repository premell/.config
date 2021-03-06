-- General
lvim.format_on_save = true
-- lvim.colorscheme = "moonfly"
-- lvim.colorscheme = "github_dark_default"
-- lvim.colorscheme = "irblack"
-- lvim.colorscheme = "blue-moon"
lvim.colorscheme = "gruvbox-material"
-- lvim.colorscheme = "base16-irblack"
-- lvim.colorscheme = "catppuccin"
lvim.leader = "space"
lvim.lsp.diagnostics.virtual_text = true

-- Keybindings
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

P = function(v)
  print(vim.inspect(v))
  return v
end

RELOAD = function (...)
  return require("plenary.reload").reload_module(...)
end

R = function (name)
  RELOAD(name)
  return require(name)
end

  -- map w <Nop>
vim.cmd([[
  cmap w!! w !sudo tee %

  map J <Nop>

  onoremap w e
  vnoremap w e
  onoremap W E
  vnoremap W E

  nnoremap Y y$
  nnoremap yy Y
  nnoremap V v$
  nnoremap vv V
  nnoremap c <Nop>
  vnoremap c <Nop>

  noremap <C-f> <C-f>zz
  noremap <C-b> <C-b>zz
  noremap <C-d> <C-d>zz
  noremap <C-u> <C-u>zz

  set clipboard+=unnamedplus

  nmap s <cmd>Pounce<CR>
  nmap S <cmd>PounceRepeat<CR>
  vmap s <cmd>Pounce<CR>
  omap gs <cmd>Pounce<CR>  " 's' is used by vim-surround
]])

-- vim.api.nvim_set_keymap("n", w, BetterW())

-- Autocommands
lvim.autocommands.custom_groups = {
  { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
   { "InsertEnter", "*", ":normal zz" },
}


-- Whichkey
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}
lvim.builtin.which_key.mappings["S"]= {
  name = "Session",
  c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}
lvim.builtin.which_key.mappings["be"]= {
  "<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>", "Close all other buffers"
}

lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.treesitter.highlight.enabled = true
lvim.builtin.treesitter.autotag.enable = true
lvim.builtin.treesitter.matchup.enable = true
lvim.builtin.treesitter.rainbow.enable = true
lvim.builtin.treesitter.textsubjects.enable = true

-- Formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    args = { '--print-with=100', '--single-quote=true' },
  },
}

-- Plugins
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {"rlane/pounce.nvim"},
  {
    "nacro90/numb.nvim",
    event = "BufRead",
    config = function()
    require("numb").setup {
      show_numbers = true, -- Enable 'number' for the window while peeking
      show_cursorline = true, -- Enable 'cursorline' for the window while peeking
    }
    end,
  },
  {
    "kevinhwang91/nvim-bqf",
    event = { "BufRead", "BufNew" },
    config = function()
    require("bqf").setup({
      auto_enable = true,
      preview = {
      win_height = 12,
      win_vheight = 12,
      delay_syntax = 80,
      border_chars = { "???", "???", "???", "???", "???", "???", "???", "???", "???" },
      },
      func_map = {
      vsplit = "",
      ptogglemode = "z,",
      stoggleup = "",
      },
      filter = {
      fzf = {
      action_for = { ["ctrl-s"] = "split" },
      extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
      },
      },
      })
    end,
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {"p00f/nvim-ts-rainbow"},
  {"catppuccin/nvim"},
  {
  "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({ "*" }, {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          })
  end,
},
{
  "tzachar/cmp-tabnine",
  run = "./install.sh",
  requires = "hrsh7th/nvim-cmp",
  event = "InsertEnter",
},
{
  "rmagatti/goto-preview",
  config = function()
  require('goto-preview').setup {
        width = 120; -- Width of the floating window
        height = 25; -- Height of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        post_open_hook = nil -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- You can use "default_mappings = true" setup option
        -- Or explicitly set keybindings
        -- vim.cmd("nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        -- vim.cmd("nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        -- vim.cmd("nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>")
    }
  end
},
{
  "ahmedkhalf/lsp-rooter.nvim",
  event = "BufRead",
  config = function()
    require("lsp-rooter").setup()
  end,
},
{
  "ray-x/lsp_signature.nvim",
  event = "BufRead",
  config = function()
    require "lsp_signature".setup()
  end
},
{
  "monaqa/dial.nvim",
  event = "BufRead",
  config = function()
    local dial = require "dial"
    vim.cmd [[
    nmap <C-a> <Plug>(dial-increment)
      nmap <C-x> <Plug>(dial-decrement)
      vmap <C-a> <Plug>(dial-increment)
      vmap <C-x> <Plug>(dial-decrement)
      vmap g<C-a> <Plug>(dial-increment-additional)
      vmap g<C-x> <Plug>(dial-decrement-additional)
    ]]

    dial.augends["custom#boolean"] = dial.common.enum_cyclic {
      name = "boolean",
      strlist = { "true", "false" },
    }
    table.insert(dial.config.searchlist.normal, "custom#boolean")

    -- For Languages which prefer True/False, e.g. python.
    dial.augends["custom#Boolean"] = dial.common.enum_cyclic {
      name = "Boolean",
      strlist = { "True", "False" },
    }
    table.insert(dial.config.searchlist.normal, "custom#Boolean")
  end,
},
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit", "gitrebase", "svn", "hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},{
  "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup {
        dir = vim.fn.expand(vim.fn.stdpath "config" .. "/session/"),
        options = { "buffers", "curdir", "tabpages", "winsize" },
      }
  end,
  },
  {"nvim-neorg/neorg"},
  {"Pocco81/AbbrevMan.nvim"},
  {"max397574/better-escape.nvim"},
  {"kdheepak/lazygit.nvim"},
  {"gpanders/nvim-parinfer"},
  {"kyazdani42/blue-moon"},
  {"sainnhe/gruvbox-material"},
  {"ellisonleao/gruvbox.nvim"},
  {"savq/melange"},
  {"ThePrimeagen/refactoring.nvim"},
  {"terryma/vim-multiple-cursors"},
  {"projekt0n/github-nvim-theme"},
  {"yashguptaz/calvera-dark.nvim"},
  {"vigoux/oak"},
  {"bluz71/vim-moonfly-colors"},
  {"marko-cerovac/material.nvim"},
  {"RRethy/nvim-base16"},
  {"my_plugins/testing"},
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "python",
  highlight = {
   enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "c",
      node_incremental = "c",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
