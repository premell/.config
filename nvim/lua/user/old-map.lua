local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
-- keymap("", "<Space>", "<Nop>", opts)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- My stuff
keymap("n", "<leader>å", ":w<CR>:source % | echo 'sourced'<CR>", opts)
keymap("n", "<C-s>", "<CMD>:w<CR>", opts)
keymap("n", "<leader>ä", ":w<CR>:source ~/.config/nvim/lua/user/luasnip.lua | echo 'snippets sourced'<CR>", opts)
-- keymap("n", "<leader><leader>", ":echo 'double space'<CR>", opts)

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

-- Insert --
-- Press jk fast to enter
-- Make this work in any mode
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("v", "jk", "<ESC>", opts)
keymap("v", "kj", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Navigate buffers __I USE HARPOON NOW INSTEAD
-- I need this aswell as HARPOON
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


--nnoremap <SPACE> <Nop>
--let mapleader=" "
-- My keybindings
vim.cmd([[
map <Space> <Leader>


  cmap w!! w !sudo tee %

  map <S-j> <Nop>
  map <S-k> <Nop>

  nnoremap <A-LeftRelease> <cmd>lua require("multiple_cursors").SayHi()<CR>

  nnoremap w <cmd>lua require("betterw").BetterW()<CR>
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

  noremap <C-s> <cmd>w<CR>

  nnoremap yy Y
  nnoremap V v$
  nnoremap vv V
  nnoremap c <Nop>

  set clipboard+=unnamedplus

  nmap s <cmd>Pounce<CR>
  nmap S <cmd>PounceRepeat<CR>
  vmap s <cmd>Pounce<CR>
  omap gs <cmd>Pounce<CR>  " 's' is used by vim-surround

  vmap Q <cmd>q<CR>  " 's' is used by vim-surround
  nmap Q <cmd>q<CR>  " 's' is used by vim-surround

  nmap <A-u> <cmd>cprev<CR>
  nmap <A-i> <cmd>cnext<CR>
  vmap <A-u> <cmd>cprev<CR>
  vmap <A-i> <cmd>cnext<CR>
 
]])

-- snippets
local ls = require("luasnip")

vim.keymap.set({"i", "s"}, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true})

vim.keymap.set({"i", "s"}, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true})

vim.keymap.set({"i", "s"}, "<c-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true})

-- SUPER COOL BUT I NEED TO BE ABLE TO MOVE BUFFERS
--   nnoremap <S-h> <cmd>lua require("harpoon.ui").nav_file(1)<CR>
--   nnoremap <S-j> <cmd>lua require("harpoon.ui").nav_file(2)<CR>
--   nnoremap <S-k> <cmd>lua require("harpoon.ui").nav_file(3)<CR>
--   nnoremap <S-l> <cmd>lua require("harpoon.ui").nav_file(4)<CR>
