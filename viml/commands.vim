" tab
vmap <Tab> >gv
vmap <S-Tab> <gv

" hop
nnoremap <leader>hw <cmd>HopWord<cr>
nnoremap <leader>hl <cmd>HopLine<cr>
nnoremap <leader>hs <cmd>HopLineStart<cr>
nnoremap <leader>ha <cmd>HopAnywhere<cr>

" Turn the word under cursor to upper case
inoremap <c-u> <Esc>viwUea

" Turn the current word into title case
inoremap <c-t> <Esc>b~lea

" Copy entire buffer.
nnoremap <silent> <leader>y :<C-U>%y<CR>

nmap <c-'> <Esc>gcc

vmap <C-'> <Esc>gcc

:tnoremap <Esc> <C-\><C-n>


" moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv