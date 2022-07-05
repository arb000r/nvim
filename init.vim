" check if we have the lastest stable version of nvim
let s:expect_ver = printf('nvim-%s', '0.7.2')
let s:actual_ver = matchstr(execute('version'), 'NVIM v\zs[^\n]*')

if !has(s:expect_ver)
    echohl Error | echomsg printf("%s required, but got nvim %s!", s:expect_ver, s:actual_ver) | echohl None
    finish
endif

let s:core_conf_files = ['plugins.vim', 'commands.vim', 'auto.vim']

for s:fname in s:core_conf_files
    execute printf('source %s/viml/%s', stdpath('config'), s:fname)
endfor

"  colorscheme
if has('termguicolors')
    set termguicolors
endif
let &t_ut=''
" For dark version.
set background=dark
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:everforest_background = 'soft'
" For better performance
let g:everforest_better_performance = 1
colorscheme dracula
syntax on
set splitright

"  mouse
set mouse=nic  " Enable mouse in several mode
set mousemodel=popup  " Set the behaviour of mouse

" line numbers
set number
