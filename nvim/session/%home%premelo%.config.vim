let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +14 ~/.config/nvim/init.lua
badd +149 nvim/lua/user/plugins.lua
badd +26 ~/.config/nvim/lua/user/options.lua
badd +27 nvim/lua/user/keymaps.lua
badd +30 nvim/lua/user/autocommands.lua
badd +15 nvim/lua/user/colorscheme.lua
badd +128 ~/.config/nvim/lua/user/cmp.lua
badd +1 nvim/lua/user/telescope.lua
badd +1 ~/.config/nvim/lua/user/treesitter.lua
badd +1 nvim/lua/user/autopairs.lua
badd +1 nvim/lua/user/comment.lua
badd +2 nvim/lua/user/gitsigns.lua
badd +1 nvim/lua/user/nvim-tree.lua
badd +1 nvim/lua/user/bufferline.lua
badd +59 nvim/lua/user/lualine.lua
badd +1 nvim/lua/user/toggleterm.lua
badd +1 nvim/lua/user/project.lua
badd +2 nvim/lua/user/impatient.lua
badd +1 ~/.config/nvim/lua/user/illuminate.lua
badd +1 nvim/lua/user/indentline.lua
badd +24 nvim/lua/user/alpha.lua
badd +1 ~/.config/nvim/lua/user/lsp/init.lua
badd +1 ~/.config/nvim/lua/user/lsp/null-ls.lua
badd +1 ~/.config/nvim/lua/user/lsp/lsp-installer.lua
badd +49 ~/.config/nvim/lua/user/lsp/handlers.lua
badd +16 ~/.config/nvim/lua/user/lsp/settings/jsonls.lua
badd +48 ~/.config/nvim/lua/user/dap.lua
argglobal
%argdel
edit ~/.config/nvim/lua/user/dap.lua
argglobal
balt ~/.config/nvim/lua/user/lsp/settings/jsonls.lua
let s:l = 1 - ((0 * winheight(0) + 24) / 48)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
