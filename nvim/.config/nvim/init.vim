call plug#begin('~/.config/nvim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'joshdick/onedark.vim'
    Plug 'Shougo/echodoc.vim'
    Plug 'dylanaraps/wal.vim'
    Plug 'dense-analysis/ale'
call plug#end()

" COLORS
color onedark

" MISIL
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

" DEOPLETE
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.php = ['ale']

" ALE
let g:ale_php_langserver_executable = expand('~/.config/composer/vendor/bin/php-language-server.php')
let g:ale_set_balloons = 1

" AIRLINE
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" ECHODOC
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

" LEADER
let mapleader = ' '

" IMAPS
imap jj <Esc>

" COMMANDS
:command! W w
:command! Config e! ~/.config/nvim/init.vim
:command! Reload source ~/.config/nvim/init.vim 

" NMAPS
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
