call plug#begin('~/.config/nvim/plugged')
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'joshdick/onedark.vim'
    Plug 'Shougo/echodoc.vim'
    Plug 'dylanaraps/wal.vim'
    "Plug 'https://gitlab.com/bloodflame/wal.vim'
    "Plug 'dense-analysis/ale'
    Plug 'cocopon/iceberg.vim'
    Plug 'vim-syntastic/syntastic'
    Plug 'kristijanhusak/deoplete-phpactor'
    "Plug 'phpactor/phpactor' ,  {'do': 'composer install', 'for': 'php'}
    "Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }
    Plug 'jiangmiao/auto-pairs'
    Plug 'preservim/nerdcommenter'
    Plug 'alvan/vim-closetag'
    Plug 'captbaritone/better-indent-support-for-php-with-html'
    Plug 'StanAngeloff/php.vim'
    Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
    Plug 'airblade/vim-gitgutter'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'mhinz/vim-startify'
call plug#end()

" CTRLP
let g:ctrlp_cmd = 'CtrlPBuffer'

" COC
let g:coc_global_extensions = ['coc-phpls', 'coc-tsserver']

" COLORS
color wal

" AUTOCLOSE TAGS
let g:closetag_filetypes = 'html,xhtml,phtml,php'
let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.php'

" MISIL
filetype on
filetype plugin on
filetype plugin indent on

" SET
set number relativenumber
set notermguicolors
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

" DEOPLETE
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources = {}
let g:deoplete#sources.php = ['ale']

" NERDTREE
let g:NERDTreeWinPos = 'right'

" ALE
let g:ale_php_langserver_executable = expand('~/.config/composer/vendor/bin/php-language-server.php')
let g:ale_linters = {
\ 'php': ['langserver']
\ }

" SYNTASTIC
let g:syntastic_vim_checkers = ['vint']

" AIRLINE
let g:airline_powerline_fonts = 1
"let g:airline#extensions#ale#enabled = 1

" ECHODOC
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'echo'

" FUNCTIONS
func! DeleteCurBufferNotCloseWindow() abort
    if &modified
        echohl ErrorMsg
        echom 'E89: no write since last change'
        echohl None
    elseif winnr('$') == 1
        bd
    else  " multiple window
        let oldbuf = bufnr('%')
        let oldwin = winnr()
        while 1   " all windows that display oldbuf will remain open
            if buflisted(bufnr('#'))
                b#
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
        exec oldbuf 'bd'
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


" askdjlakjsdlaksjdlakjsd
