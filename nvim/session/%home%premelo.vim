let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +409 notes.norg
argglobal
%argdel
$argadd notes.norg
edit notes.norg
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '2resize ' . ((&lines * 22 + 16) / 32)
exe 'vert 2resize ' . ((&columns * 88 + 54) / 108)
argglobal
let s:l = 409 - ((389 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 409
normal! 033|
wincmd w
argglobal
if bufexists(fnamemodify("term://~//60854:/usr/bin/fish;\#toggleterm\#1", ":p")) | buffer term://~//60854:/usr/bin/fish;\#toggleterm\#1 | else | edit term://~//60854:/usr/bin/fish;\#toggleterm\#1 | endif
if &buftype ==# 'terminal'
  silent file term://~//60854:/usr/bin/fish;\#toggleterm\#1
endif
balt notes.norg
let s:l = 1 - ((0 * winheight(0) + 11) / 22)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 07|
wincmd w
2wincmd w
exe '2resize ' . ((&lines * 22 + 16) / 32)
exe 'vert 2resize ' . ((&columns * 88 + 54) / 108)
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
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
