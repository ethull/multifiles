"" cmd mode abbreviations (shortcuts/autocorrect)
"cnoreabbrev W! w!
"cnoreabbrev Q! q!

"" splits
noremap <Leader>s :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" resize window
" recomend remaping window operations resize splits to avoid ctrl + w + shift 
" popular nnoremap +-<> <C-w>+-<>  
" can use HJKL as this works nice in tmux as prefix-HJKL
"nnoremap K <C-w>+
"nnoremap J  <C-w>-
"nnoremap H  <C-w>< 
"nnoremap L <C-w>> 
" i want KJHL to be free
" ^W+^W+^W- -> ^W++-
nmap <C-W>+ <C-W>+<SID>ws
nmap <C-W>- <C-W>-<SID>ws
nn <script> <SID>ws+ <C-W>+<SID>ws
nn <script> <SID>ws- <C-W>-<SID>ws
nmap <SID>ws <Nop>
nmap <C-W>< <C-W><<SID>ws
nmap <C-W>> <C-W>><SID>ws
nn <script> <SID>ws< <C-W><<SID>ws
nn <script> <SID>ws> <C-W>><SID>ws
nmap <SID>ws <Nop>

"" navigation
""" tabs
"nnoremap <Tab> gt
"nnoremap <S-Tab> gT
"nnoremap <silent> <S-t> :tabnew<CR>
""" set working directory
nnoremap <leader>. :lcd %:p:h<CR>
" opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"  opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <leader>e. :put=expand('%:p')<CR>
""" buffers
""" buffer nav
"noremap <leader>bn :bn<CR>
"noremap <leader>bp :bp<CR>
" close buffer
"noremap <leader>bc :bd<CR>

"" clipboard setup
noremap Y y$
""" map global register to ; (so can use ;yy for copy to global register)
noremap ; "+
""" in insert mode ctrl-c is disabled, ctrl-v copies from the unamed register
"inoremap <C-c> <NOP>
"inoremap <C-v> <C-r>"

"" visual mode
""" move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" vmap for maintain visual mode after shifting > and <
vmap < <gv
vmap > >gv

"" other
""" search mappings: these will make it so that going to the next one in a
" search will center on the line it's found in
nnoremap n nzzzv
nnoremap N Nzzzv
""" undo stuff
nnoremap U <C-r>
""" terminal emulation
nnoremap <silent> <leader>sh :terminal<CR>
""" clean search (highlight)
nnoremap <silent> <leader>no :noh<cr>
