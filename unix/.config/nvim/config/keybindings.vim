" --- resize window
" resize up / down
nmap <C-W>+ <C-W>+<SID>ws
nmap <C-W>- <C-W>-<SID>ws
nn <script> <SID>ws+ <C-W>+<SID>ws
nn <script> <SID>ws- <C-W>-<SID>ws
nmap <SID>ws <Nop>
" resize left/right
nmap <C-W>< <C-W><<SID>ws
nmap <C-W>> <C-W>><SID>ws
nn <script> <SID>ws< <C-W><<SID>ws
nn <script> <SID>ws> <C-W>><SID>ws
nmap <SID>ws <Nop>

" --- navigation
" set working directory
nnoremap <leader>. :lcd %:p:h<CR>
" opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"  opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>e. :put=expand('%:p')<CR>

" --- clipboard setup
noremap Y y$
" map global register to ;
noremap ; "+
""" in insert mode ctrl-c is disabled, ctrl-v copies from the unamed register
"inoremap <C-c> <NOP>
"inoremap <C-v> <C-r>"

" --- visual mode
""" move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" vmap for maintain visual mode after shifting > and <
vmap < <gv
vmap > >gv

" --- other
" search mappings: these will make it so that going to the next one in a search will center on the line it's found in
nnoremap n nzzzv
nnoremap N Nzzzv

" undo stuff
nnoremap U <C-r>
" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
" clean search (highlight)
nnoremap <silent> <leader>no :noh<cr>

" cmd mode abbreviations (shortcuts/autocorrect)
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev W! w!
cnoreabbrev Q! q!

" splits
noremap <Leader>s :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>
