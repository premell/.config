let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/.config/nvim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +21 init.lua
badd +30 my_plugins/betterw/lua/betterw/init.lua
badd +81 lua/user/keymaps.lua
badd +96 lua/user/whichkey.lua
badd +1 lua/user/lsp/null-ls.lua
badd +1 lua/user/lsp/lsp-installer.lua
badd +2 lua/user/lsp/init.lua
badd +55 lua/user/lsp/handlers.lua
badd +1 lua/user/lsp/settings/jsonls.lua
badd +17 lua/user/lsp/settings/sumneko_lua.lua
badd +35 lua/user/options.lua
argglobal
%argdel
edit lua/user/options.lua
argglobal
balt lua/user/lsp/settings/sumneko_lua.lua
let s:l = 45 - ((44 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 45
normal! 028|
lcd ~/.config/nvim/lua/user
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=tiofTOlcxnF
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
