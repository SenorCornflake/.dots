
"source ~/.config/nvim/plugin/startscreen/start.vim

call plug#begin('~/.config/nvim/plugged')

" Plug 'Shougo/deoplete.nvim'
" Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
" Plug 'deoplete-plugins/deoplete-jedi'
" Plug 'carlitux/deoplete-ternjs'
" Plug 'kristijanhusak/deoplete-phpactor'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --all' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'scrooloose/nerdtree'
Plug 'dracula/vim'
Plug 'ternjs/tern_for_vim', {'do': 'npm install && npm install -g tern'}
" Plug 'mhinz/vim-startify'

call plug#end()

let g:ycm_auto_trigger = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" Remap C-n and C-p to j/k while scrolling though completion
" inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
" inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))

" Basic stuff
set number relativenumber
color default
set title titlestring=Neovim
set termguicolors

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" Set W to also save, avoiding annoying mistakes
command! W :w

" Map ii as Escape
imap ii <Esc>

" Decrease time needed in order for keypresses to count as keybindings
set timeout timeoutlen=200

" Better split window movement
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-q> <c-w>q

" Better searches
set hlsearch
set incsearch
set ignorecase
set smartcase
nnoremap <CR> :nohlsearch<CR>


