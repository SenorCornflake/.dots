let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd /srv/http/drivecodrivingschool.dv/public_html
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +14 wp-content/themes/driveco-driving-school/new_css/woocommerce.css
badd +38 wp-content/themes/driveco-driving-school/new_css/basics.css
badd +20 wp-content/themes/driveco-driving-school/new_css/product.css
badd +13 wp-content/themes/driveco-driving-school/css/main.css
badd +21 wp-content/themes/driveco-driving-school/new_css/main.css
badd +4 wp-content/themes/driveco-driving-school/woocommerce.php
badd +46 wp-content/themes/driveco-driving-school/functions.php
badd +0 __vista__
argglobal
%argdel
edit wp-content/themes/driveco-driving-school/new_css/main.css
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 119 + 134) / 269)
exe 'vert 2resize ' . ((&columns * 118 + 134) / 269)
exe 'vert 3resize ' . ((&columns * 30 + 134) / 269)
argglobal
balt wp-content/themes/driveco-driving-school/css/main.css
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 21 - ((20 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 21
normal! 09|
wincmd w
argglobal
if bufexists("wp-content/themes/driveco-driving-school/new_css/basics.css") | buffer wp-content/themes/driveco-driving-school/new_css/basics.css | else | edit wp-content/themes/driveco-driving-school/new_css/basics.css | endif
if &buftype ==# 'terminal'
  silent file wp-content/themes/driveco-driving-school/new_css/basics.css
endif
balt wp-content/themes/driveco-driving-school/new_css/product.css
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 38 - ((27 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 38
normal! 0
wincmd w
argglobal
if bufexists("__vista__") | buffer __vista__ | else | edit __vista__ | endif
if &buftype ==# 'terminal'
  silent file __vista__
endif
balt wp-content/themes/driveco-driving-school/new_css/basics.css
setlocal fdm=expr
setlocal fde=vista#fold#Expr()
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 134) / 269)
exe 'vert 2resize ' . ((&columns * 118 + 134) / 269)
exe 'vert 3resize ' . ((&columns * 30 + 134) / 269)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFI
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
