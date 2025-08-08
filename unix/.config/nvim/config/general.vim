" options
" set nocompatible " NEOVIM: Always set by default in Neovim, not needed
" swap files
set directory=$HOME/.vim/swapfiles//
" lookup 
" set autoread " NEOVIM: Default in Neovim, automatically reloads files changed outside vim

" encoding
" set encoding=utf-8 " NEOVIM: UTF-8 is default encoding in Neovim
set fileencoding=utf-8
set fileencodings=utf-8
" set ttyfast " NEOVIM: Not relevant in Neovim, terminal is always considered fast

" fix backspace indent
" set backspace=indent,eol,start " NEOVIM: Default behavior in Neovim
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
" set hidden " NEOVIM: Default in Neovim, allows switching buffers without saving

" searching
" set hlsearch " NEOVIM: Default in Neovim, highlights search results
" set incsearch " NEOVIM: Default in Neovim, shows matches as you type
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
" syntax on " NEOVIM: Syntax highlighting is enabled by default
" set ruler " NEOVIM: Default in Neovim, shows cursor position
set number
let no_buffers_menu=1
"set background=dark
silent! colorscheme zenburn
" disable match brackets (to stop annoying bracket jumping), instead use %
let g:loaded_matchparen=1

" other stuff
" set mousemodel=popup " NEOVIM: GUI-specific, less relevant for modern Neovim
" set t_Co=256 " NEOVIM: Not needed, Neovim handles colors automatically
" set guioptions=egmrti " NEOVIM: GUI-specific, less relevant for modern Neovim
" set gfn=Monospace\ 10 " NEOVIM: GUI font, less relevant for modern Neovim
set fileformats=unix,dos,mac
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif
" Terminal color settings - NEOVIM: Not needed, Neovim handles terminal colors automatically
" if $COLORTERM == 'gnome-terminal'
" set term=gnome-256color
" else
" if $TERM == 'xterm'
"   set term=xterm-256color
" endif
" endif  
" if &term =~ '256color'
"   set t_ut=
" endif
" disable the blinking cursor (breaks cursor on nvim)
"set gcr=a:blinkon0
set scrolloff=3

" status bar
" set laststatus=2 " NEOVIM: Default in Neovim, always show statusline
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

" change cursor in insert mode - NEOVIM: Use modern Neovim approach
" let &t_SI = "\e[6 q" " NEOVIM: Terminal escape sequences, use guicursor instead
" let &t_EI = "\e[2 q" " NEOVIM: Terminal escape sequences, use guicursor instead
" Modern Neovim cursor shape configuration:
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20
 
" include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
