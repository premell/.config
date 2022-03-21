let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +34 programming/machine_learning/ai_snake/utils.py
badd +1 ~/programming/machine_learning/ai_snake/testing.py
badd +25 ~/programming/machine_learning/ai_snake/agent.py
badd +20 ~/programming/machine_learning/ai_snake/game_ai.py
badd +109 ~/programming/machine_learning/ai_snake/game.py
badd +1 ~/programming/machine_learning/ai_snake/model.py
argglobal
%argdel
$argadd ai_snake/
edit programming/machine_learning/ai_snake/utils.py
argglobal
balt ~/programming/machine_learning/ai_snake/testing.py
let s:l = 80 - ((23 * winheight(0) + 16) / 32)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 80
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=cOxtTFnfilo
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
