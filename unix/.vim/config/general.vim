"" options
set nocompatible
""" swap files
"set directory=/tmp
""" lookup 
set autoread
""" encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
""" fix backspace indent
set backspace=indent,eol,start
""" stop delay when changing back to normal mode
set timeoutlen=1000 ttimeoutlen=0
""" tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
""" splits, natural split opening
set splitbelow
set splitright
""" map leader
nnoremap <SPACE> <Nop>
let mapleader=' '
let g:maplocalleader = ','
""" enable hidden buffers
set hidden
""" searching
set hlsearch
set incsearch
set ignorecase
set smartcase
""" use modeline overrides
set modeline
set modelines=10
""" options for coc.nvim (lsp's)
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
""" visual settings
syntax on
set ruler
set number
let no_buffers_menu=1
silent! colorscheme zenburn
" disable match brackets (to stop annoying bracket jumping), instead use %
let g:loaded_matchparen=1
""" other
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
" disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3
" status bar
set laststatus=2
set title
set titleold="yeet 69 420"
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

"" commands
" remove trailing whitespaces
command! FixWhitespace :%s/\s\+$//e
" save file as root
command! -nargs=0 Sw w !sudo tee % > /dev/null

"" functions
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"" autocmd rules
""" change cursor in insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
""" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END
""" the pc is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END
""" remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
""" disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif
""" disable settings for faster loading of large files
augroup LargeFile 
  au!
  autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:largeFileSize || f == -2 | call LargeFile() | endif
augroup END
function! LargeFile()
  " no syntax highlighting etc
  "set eventignore+=FileType
  " save memory when other file is viewed
  setlocal bufhidden=unload
  " is read-only (write with :w new_filename)
  setlocal buftype=nowrite
  " no undo possible
  setlocal undolevels=-1
  " display message
  autocmd VimEnter *  echo "The file is larger than " . (g:largeFileSize / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction
""" setup lesspipe
if exists('g:did_load_filetypes')
  if executable('lesspipe.sh')
    let s:lesspipe_cmd = 'LESSQUIET=1 lesspipe.sh'
  elseif executable('lesspipe')
    let s:lesspipe_cmd = 'lesspipe'
  endif
  "open unknown filetypes with lesspipe
  if exists('s:lesspipe_cmd') && executable('file')
    augroup lesspipe
      autocmd!
      autocmd BufReadPost *
            \ if  empty(&l:buftype) && !did_filetype() && !&l:binary && filereadable(bufname('%')) &&
            \     system('file --mime --brief ' . fnamemodify(resolve(expand('%')), ':p:S')) !~# '^text/' |
            \   silent exe '%!' . s:lesspipe_cmd . ' ' . expand('%:S') |
            \   setlocal filetype=text nomodifiable readonly |
            \ endif
	  augroup END
   endif
endif
"""" use lesspipe for pdf 
autocmd Filetype pdf
      \ exe '%!' . s:lesspipe_cmd . ' ' . expand('%:S') |
      \ setlocal filetype=text nomodifiable readonly |
 
"" include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
