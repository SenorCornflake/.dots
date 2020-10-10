" Map leader to which_key
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" By default which key floats, we disable it here
let g:which_key_use_floating_win = 0


" Create map to add keys to
let g:which_key_map =  {}

let g:which_key_map['w'] = [':w', 'Write']
let g:which_key_map['q'] = [':q', 'Quit']
let g:which_key_map['z'] = [':Goyo 60%x100%', 'Zen Mode']
let g:which_key_map['r'] = [':Rooter', 'Vim Rooter']
let g:which_key_map['e'] = [':CocCommand explorer --position right', 'File Explorer']
let g:which_key_map['k'] = ['<Plug>(easymotion-s)', 'Jump to char']

let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'              , 'history'],
      \ ';' : [':Commands'              , 'commands'],
      \ 'b' : [':Buffers'               , 'open buffers'],
      \ 'c' : [':Commits'               , 'commits'],
      \ 'C' : [':BCommits'              , 'buffer commits'],
      \ 'f' : [':Files'                 , 'files'],
      \ 'g' : [':GFiles'                , 'git files'],
      \ 'G' : [':GFiles?'               , 'modified git files'],
      \ 'h' : [':History'               , 'file history'],
      \ 'H' : [':History:'              , 'command history'],
      \ 'l' : [':BLines'                , 'current buffer'],
      \ 'L' : [':Lines'                 , 'lines'] ,
      \ 'm' : [':Marks'                 , 'marks'] ,
      \ 'M' : [':Maps'                  , 'normal maps'] ,
      \ 'p' : [':Helptags'              , 'help tags'] ,
      \ 'r' : [':Rg'                    , 'text Rg'],
      \ 'S' : [':Colors'                , 'color schemes'],
      \ 't' : [':BTags'                 , 'Buffer tags'],
      \ 'T' : [':Tags'                  , 'Project tags'],
      \ 'w' : [':Windows'               , 'search windows'],
      \ 'y' : [':Filetypes'             , 'file types'],
      \ 'z' : [':FZF'                   , 'FZF'],
      \ }

let g:which_key_map.j = {
      \ 'name' : '+easymotion',
      \ 's' : ['<Plug>(easymotion-s)', 'jump to char'],
      \ 'S' : ['<Plug>(easymotion-s2)', 'jump to multi char'],
      \ 'w' : ['<Plug>(easymotion-bd-w)', 'jump to start of word'],
      \ 'e' : ['<Plug>(easymotion-bd-e)', 'jump to end of word'],
      \ 'l' : ['<Plug>(easymotion-lineanywhere)', 'jump to word in line'],
      \ 'a' : ['<Plug>(easymotion-jumptoanywhere)', 'jump to anywhere'],
      \ 'L' : ['<Plug>(easymotion-bd-jk)', 'jump to line'],
      \ }

let g:which_key_map.S = {
      \ 'name' : '+session' ,
      \ 'c' : [':SClose'          , 'Close Session']  ,
      \ 'd' : [':SDelete'         , 'Delete Session'] ,
      \ 'l' : [':SLoad'           , 'Load Session']     ,
      \ 's' : [':SSave'           , 'Save Session']   ,
      \ 'S' : [':Startify'        , 'Start Page']     ,
      \ }

let which_key_map.P = {
    \ 'name' : '+vim-plug',
    \ 'i' : [':PlugInstall', 'Install Plugins'],
    \ 'c' : [':PlugClean', 'Clean Plugins'],
    \ 'u' : [':PlugUpdate', 'Update Plugins'],
    \ 'U' : [':PlugUpgrade', 'Update vim-plug'],
    \ }

let which_key_map['o'] = {
      \ 'name' : '+other',
      \ '.' : [':e $MYVIMRC', 'Edit config file'],
      \ 'r' : [':source $MYVIMRC', 'Reload config file'],
      \ 'p' : [':pwd', 'Show root directory'],
      \ }

let which_key_map['c'] = {
                  \ 'name' : '+comment',
                  \ 's' : ['<Plug>NERDCommenterSexy', 'Sexy comment'],
                  \ 'c' : ['<Plug>NERDCommenterToggle', 'Comment'],
                  \ 'n' : ['<Plug>NERDCommenterUncomment', 'Uncomment'],
                  \ }

let which_key_map.b = {
                  \ 'name' : '+buffer',
                  \ 'd': [':bd', 'Delete buffer'],
                  \ 'l': [':Buffers', 'List buffers']
                  \}

let which_key_map.l = {
                  \ 'name' : '+lsp',
                  \ '.' : [':CocConfig', 'Config'],
                  \ 'i' : [':CocList diagnostics', 'Diagnostics'],
                  \ 'd' : ["<Plug>(coc-definition)", "Definition"]
                  \ }
call which_key#register(' ', "g:which_key_map")


