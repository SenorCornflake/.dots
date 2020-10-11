" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif


call plug#begin('~/.config/nvim/autoload/plugged')
    Plug 'sheerun/vim-polyglot'
    Plug 'cocopon/iceberg.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'liuchengxu/vim-which-key'
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	Plug 'airblade/vim-rooter'
	Plug 'junegunn/goyo.vim'
	Plug 'mhinz/vim-startify'
	Plug 'jiangmiao/auto-pairs'
	Plug 'preservim/nerdcommenter'
	Plug 'Shougo/echodoc'
	Plug 'chriskempson/base16-vim'
	Plug 'tpope/vim-surround'
	Plug 'brainfucksec/wal.vim'
	Plug 'richtan/pywal.vim'
	" Plug 'dylanaraps/wal.vim'
	Plug 'easymotion/vim-easymotion'
	Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
	Plug 'tpope/vim-fugitive'
	Plug 'mhinz/vim-signify'
	Plug 'tpope/vim-rhubarb'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
