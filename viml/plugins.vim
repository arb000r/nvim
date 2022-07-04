" Plugin specification and lua stuff
lua require('lua-init')

"  shortcuts for packer commands
call utils#Cabbrev('pi', 'PackerInstall')
call utils#Cabbrev('pud', 'PackerUpdate')
call utils#Cabbrev('pc', 'PackerClean')
call utils#Cabbrev('ps', 'PackerSync')

""""""""""""""""""""""""""""""wilder.nvim settings""""""""""""""""""""""""""""""
call timer_start(250, { -> s:wilder_init() })

function! s:wilder_init() abort
  try
    call wilder#setup({
          \ 'modes': [':', '/', '?'],
          \ 'next_key': '<Tab>',
          \ 'previous_key': '<S-Tab>',
          \ 'accept_key': '<C-y>',
          \ 'reject_key': '<C-e>'
          \ })

    call wilder#set_option('pipeline', [
          \   wilder#branch(
          \     wilder#cmdline_pipeline({
          \       'language': 'python',
          \       'fuzzy': 1,
          \       'sorter': wilder#python_difflib_sorter(),
          \       'debounce': 30,
          \     }),
          \     wilder#python_search_pipeline({
          \       'pattern': wilder#python_fuzzy_pattern(),
          \       'sorter': wilder#python_difflib_sorter(),
          \       'engine': 're',
          \       'debounce': 30,
          \     }),
          \   ),
          \ ])

    let l:hl = wilder#make_hl('WilderAccent', 'Pmenu', [{}, {}, {'foreground': '#f4468f'}])
    call wilder#set_option('renderer', wilder#popupmenu_renderer(wilder#popupmenu_palette_theme({
          \ 'highlighter': wilder#basic_highlighter(),
          \ 'highlights': {
          \   'accent': l:hl,
          \ },
          \ 'left': [' ', wilder#popupmenu_devicons(),],
          \ 'right': [' ', wilder#popupmenu_scrollbar(),],
          \ 'apply_incsearch_fix': 0,
          \ 'border': 'rounded',
          \ 'max_height': '75%',
          \ 'min_height': 0,
          \ 'prompt_position': 'top',
          \ 'reverse': 0,
          \ })))
  catch /^Vim\%((\a\+)\)\=:E117/
    echohl Error |echomsg "Wilder.nvim missing: run :PackerSync to fix."|echohl None
  endtry
endfunction

""""""""""""""""""""""""""""""telescope.nvim settings""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

""""""""""""""""""""""""""""""nvim-tree.nvim settings""""""""""""""""""""""""""""""
nnoremap <C-B> <cmd>NvimTreeToggle<cr>
