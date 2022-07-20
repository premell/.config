-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "


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

-- JK for escape
keymap("i", "jk", "<ESC>", opts)
keymap("i", "kj", "<ESC>", opts)
keymap("v", "jk", "<ESC>", opts)
keymap("v", "kj", "<ESC>", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Dont save pasted text to register
keymap("v", "p", '"_dP', opts)

-- Navigate buffers
keymap("n", "<S-k>", ":bnext<CR>", opts)
keymap("n", "<S-j>", ":bprevious<CR>", opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opts)


  -- nnoremap w <cmd>lua require("betterw").BetterW()<CR>
  -- onoremap w e
  -- vnoremap w e
  -- onoremap W E
  -- vnoremap W E
-- TODO add diagnostics bindings
vim.cmd([[
  " This is not working
  "cnoremap w!! w !sudo tee %

  set clipboard+=unnamedplus

  " map <S-j> <Nop>
  " map <S-k> <Nop>


  nnoremap Y y$
  nnoremap yy Y
  nnoremap V v$
  nnoremap vv V
  vnoremap yy Y
  vnoremap V v$
  vnoremap vv V
  vnoremap c <Nop>

  " nnoremap c <Nop>
  " vnoremap c <Nop>

  noremap <C-f> <C-f>zz
  noremap <C-b> <C-b>zz
  noremap <C-d> <C-d>zz
  noremap <C-u> <C-u>zz

  noremap <C-s> <cmd>w<CR>
  noremap <leader-w> <cmd>w!<CR>
  noremap <leader-q> <cmd>q!<CR>

  noremap <C-o> <C-o>zz
  noremap <C-i> <C-i>zz

  noremap n nzz
  noremap N Nzz

  " I never use this
  " nmap s <cmd>Pounce<CR>
  " nmap S <cmd>PounceRepeat<CR>
  " vmap s <cmd>Pounce<CR>
  " omap gs <cmd>Pounce<CR>  " 's' is used by vim-surround

  vmap Q @q
  nmap Q @q

  imap <A-u> <cmd>cprev<CR>zz
  imap <A-i> <cmd>cnext<CR>zz
  nmap <A-u> <cmd>cprev<CR>zz
  nmap <A-i> <cmd>cnext<CR>zz
  vmap <A-u> <cmd>cprev<CR>zz
  vmap <A-i> <cmd>cnext<CR>zz

  nnoremap <C-S-h> <cmd>lua require("harpoon.ui").nav_file(1)<CR>
  nnoremap <C-S-j> <cmd>lua require("harpoon.ui").nav_file(2)<CR>
  nnoremap <C-S-k> <cmd>lua require("harpoon.ui").nav_file(3)<CR>
  nnoremap <C-S-l> <cmd>lua require("harpoon.ui").nav_file(4)<CR>

  inoremap <c-bs> <c-w>

  " nnoremap <A-h> <cmd>lua require("harpoon.ui").nav_file(1)<CR>
  " nnoremap <A-j> <cmd>lua require("harpoon.ui").nav_file(2)<CR>
  " nnoremap <A-k> <cmd>lua require("harpoon.ui").nav_file(3)<CR>
  " nnoremap <A-l> <cmd>lua require("harpoon.ui").nav_file(4)<CR>
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
