" options
set nocompatible
" swap files
set directory=$HOME/.vim/swapfiles//
" lookup 
set autoread

" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" fix backspace indent
set backspace=indent,eol,start
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

" enable hidden buffers
set hidden

" searching
set hlsearch
set incsearch
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
syntax on
set ruler
set number
let no_buffers_menu=1
"set background=dark
silent! colorscheme zenburn
" disable match brackets (to stop annoying bracket jumping), instead use %
let g:loaded_matchparen=1

" other stuff
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10
set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
" color settings for old terminals
if $COLORTERM == 'gnome-terminal'
set term=gnome-256color
else
if $TERM == 'xterm'
  set term=xterm-256color
endif
endif  
if &term =~ '256color'
  set t_ut=
endif
" disable the blinking cursor (breaks cursor on nvim)
"set gcr=a:blinkon0
set scrolloff=3

" status bar
set laststatus=2
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

" change cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
 
" include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
