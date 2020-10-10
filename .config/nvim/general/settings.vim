
filetype plugin indent on               " Enable filetype detection together with loading plugin files and indent files (What i understood from the help page)
set tabstop=4                           " Insert 4 spaces for a tab
set hidden                              " Keep buffers open, do not ask to write file when opening a new file and keeps undo history of the previous buffer
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set number                              " Show line numbers
set relativenumber                      " relativenumbers
set timeoutlen=300                      " Time required to register key mapping
set noshowmode                          " Do not show mode markers
set cmdheight=1                         " Set cmdheight
set nobackup                            " Coc recommendation, Some servers have issues with backup files, see #649.
set nowritebackup                       " Coc recommendation, Some servers have issues with backup files, see #649.
set updatetime=4000                     " Setting shorter updatetime for better experience, recommended by Coc
set shortmess+=c                        " Prevents sending messages to ins-complete-menu, whatever that means. Recommended by Coc
set signcolumn=yes                      " Show sign columns
set laststatus=2                        " Always show status line
set foldmethod=syntax                   " Set method used to fold blocks

let g:php_folding = 1                   " Enable folding php functions etc


" The comments below are used as identifiers by audot
" CURSORLINE
set cursorline
" TERMGUICOLORS
set termguicolors


" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
            \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
