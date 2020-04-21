" ColoSalad - Simple colorscheme for terminal VIM
hi clear normal
set bg&
hi clear
if exists("syntax_on")
  syntax reset
endif

hi CursorLine   cterm=none       ctermbg=none  cterm=underline
hi CursorLineNr ctermfg=none     ctermbg=none  cterm=bold
hi Visual       ctermfg=black    ctermbg=LightCyan
hi Error        ctermfg=darkred  ctermbg=250   cterm=none
hi StatusLine   ctermfg=16       ctermbg=250   cterm=bold
hi StatusLineNC ctermfg=16       ctermbg=250   cterm=none
hi VertSplit    ctermfg=16       ctermbg=250   cterm=bold
hi Search       ctermfg=3        ctermbg=none  cterm=underline
hi LineNr       ctermfg=8        ctermbg=none
hi Folded       ctermfg=none     ctermbg=none
hi Statement    ctermfg=96       cterm=bold
hi PmenuSel     ctermfg=16       ctermbg=250   cterm=bold
hi Pmenu        ctermbg=none     ctermfg=6
hi PmenuSbar    ctermbg=darkgrey
hi PmenuThumb   ctermbg=15
hi Comment      ctermfg=88
hi Constant     ctermfg=none
hi Identifier   ctermfg=none
hi PreProc      ctermfg=none
hi Type         ctermfg=none
hi Special      ctermfg=none
hi Ignore       ctermfg=none
hi SpecialKey   ctermfg=darkgreen
hi NonText      ctermfg=none   cterm=bold
hi Todo         ctermfg=darkred
hi String       ctermfg=98
hi Number       ctermfg=94

let colors_name = "colosalad"
