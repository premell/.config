let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/zmk-again
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +1 config/cradio.keymap
argglobal
%argdel
$argadd config/
edit config/cradio.keymap
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '2resize ' . ((&lines * 54 + 32) / 64)
exe 'vert 2resize ' . ((&columns * 80 + 73) / 146)
argglobal
let s:l = 1 - ((0 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 02|
wincmd w
argglobal
if bufexists(fnamemodify("term://~/zmk-again//10011:lazygit;\#toggleterm\#1", ":p")) | buffer term://~/zmk-again//10011:lazygit;\#toggleterm\#1 | else | edit term://~/zmk-again//10011:lazygit;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~/zmk-again//10011:lazygit;\#toggleterm\#1
endif
balt config/cradio.keymap
let s:l = 52 - ((51 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 52
normal! 039|
wincmd w
2wincmd w
exe '2resize ' . ((&lines * 54 + 32) / 64)
exe 'vert 2resize ' . ((&columns * 80 + 73) / 146)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
