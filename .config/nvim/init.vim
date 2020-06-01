call plug#begin('~/.config/nvim/plugged')
    " AIRLINE
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

    " DEOPLETE
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    " ALE
    Plug 'dense-analysis/ale'
    
    Plug 'Shougo/echodoc.vim'
    Plug 'sheerun/vim-polyglot'
    Plug 'captbaritone/better-indent-support-for-php-with-html'
    Plug 'airblade/vim-gitgutter'
    Plug 'ctrlpvim/ctrlp.vim'

    " COLORS
    Plug 'tomasiser/vim-code-dark'
    Plug 'arcticicestudio/nord-vim'
    Plug 'chriskempson/base16-vim'
call plug#end()

" DEOPLETE
let g:deoplete#enable_at_startup = 1
" CTRLP
let g:ctrlp_cmd = 'CtrlPBuffer'

" COLORS
 color base16-oceanicnext

" MISIL
filetype on
filetype plugin on
filetype plugin indent on

" SET
set number relativenumber
set termguicolors
set splitbelow
set splitright
set tabstop=4
set shiftwidth=4
set expandtab
set noshowmode
set cmdheight=1
set mouse=a
set ignorecase
set smartcase
set incsearch
set hidden 
"set t_Co=16


" NERDTREE
let g:NERDTreeWinPos = 'right'

" AIRLINE
let g:airline_powerline_fonts = 1
"let g:airline#extensions#ale#enabled = 1
"let g:airline_theme = "wal"


"" ECHODOC
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

" FUNCTIONS
func! DeleteCurBufferNotCloseWindow() abort
    if &modified
        echohl ErrorMsg
        echom 'E89: no write since last change'
        echohl None
    elseif winnr('$') == 1
        bd!
    else  " multiple window
        let oldbuf = bufnr('%')
        let oldwin = winnr()
        while 1   " all windows that display oldbuf will remain open
            if buflisted(bufnr('#'))
                b#!
            else
                bn
                let curbuf = bufnr('%')
                if curbuf == oldbuf
                    enew    " oldbuf is the only buffer, create one
                endif
            endif
            let win = bufwinnr(oldbuf)
            if win == -1
                break
            else        " there are other window that display oldbuf
                exec win 'wincmd w'
            endif
        endwhile
        " delete oldbuf and restore window to oldwin
        exec oldbuf 'bd!'
        exec oldwin 'wincmd w'
    endif
endfunc

" LEADER
let mapleader = ' '

" IMAPS
imap jj <Esc>
imap ii <Esc>

" COMMANDS
command! W w
command! Config e! ~/.config/nvim/init.vim
command! CONFIG e! ~/.config/nvim/init.vim
command! Reload source ~/.config/nvim/init.vim 

" NMAPS
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> <leader><cr> :nohl<cr>
nnoremap <silent> <leader>n :NERDTreeToggle<cr>
nnoremap <leader>v :vsp<cr>
nnoremap <leader>s :sp<cr>
nnoremap <silent> <leader>q :call DeleteCurBufferNotCloseWindow()<cr>


