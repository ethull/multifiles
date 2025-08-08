" options
" swap files
set directory=$HOME/.vim/swapfiles//
" lookup 

" encoding
set fileencoding=utf-8
set fileencodings=utf-8

" fix backspace indent
" stop delay when changing back to normal mode
set timeoutlen=1000 ttimeoutlen=0

" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" splits, natural split opening
set splitbelow
set splitright

" map leader
nnoremap <SPACE> <Nop>
let mapleader=' '
let g:maplocalleader = ','

" searching
set ignorecase
set smartcase

" use modeline overrides
set modeline
set modelines=10

" options for lsp's
" some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" better display for messages
set cmdheight=2
" you will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

" visual settings
set number
let no_buffers_menu=1
"set background=dark
silent! colorscheme zenburn
" disable match brackets (to stop annoying bracket jumping), instead use %
let g:loaded_matchparen=1

" other stuff
set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
" disable the blinking cursor (breaks cursor on nvim)
"set gcr=a:blinkon0
set scrolloff=3

" status bar
set title
set titleold="yeet 69 420"
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e
" save file as root
command! -nargs=0 Sw w !sudo tee % > /dev/null

" setup text wrapping
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

" Modern Neovim cursor shape configuration:
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
 
" include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
