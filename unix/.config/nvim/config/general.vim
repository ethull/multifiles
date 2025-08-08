" ================================================================================
" NEOVIM GENERAL CONFIGURATION
" ================================================================================
" This file contains general Neovim settings organized by functional areas.
" Settings that are default in Neovim are commented out with explanations.

" ================================================================================
" FILE AND BUFFER MANAGEMENT
" ================================================================================

" Swap files configuration
set directory=$HOME/.vim/swapfiles//

" File encoding settings
set fileencoding=utf-8
set fileencodings=utf-8

" File format handling
set fileformats=unix,dos,mac

" Backup settings (important for LSPs)
set nobackup
set nowritebackup

" ================================================================================
" INPUT AND NAVIGATION
" ================================================================================

" Leader key configuration
nnoremap <SPACE> <Nop>
let mapleader=' '
let g:maplocalleader = ','

" Input timing settings
set timeoutlen=1000 ttimeoutlen=0  " Stop delay when changing back to normal mode

" Mouse support - enables mouse in all modes
set mouse=a

" ================================================================================
" TABS AND INDENTATION
" ================================================================================

set tabstop=4      " Number of visual spaces per TAB
set softtabstop=4  " Number of spaces in tab when editing
set shiftwidth=4   " Number of spaces to use for autoindent
set expandtab      " Tabs are spaces

" ================================================================================
" WINDOW AND SPLIT BEHAVIOR
" ================================================================================

" Natural split opening
set splitbelow  " Open horizontal splits below current window
set splitright  " Open vertical splits to the right of current window

" Scrolling behavior
set scrolloff=3  " Keep 3 lines visible above/below cursor

" ================================================================================
" SEARCH CONFIGURATION
" ================================================================================

" Search behavior
set ignorecase  " Case insensitive searching
set smartcase   " Smart case sensitivity (case sensitive if uppercase used)

" Modern Neovim search enhancements
set inccommand=split  " NEOVIM: Live preview of substitute commands in split window

" Commented out - these are default in Neovim:
" set hlsearch    " NEOVIM: Default - highlights search results
" set incsearch   " NEOVIM: Default - shows matches as you type

" ================================================================================
" VISUAL AND DISPLAY SETTINGS
" ================================================================================

" Line numbers and visual aids
set number  " Show line numbers

" Color scheme and syntax
silent! colorscheme zenburn
let no_buffers_menu=1
"set background=dark

" Disable match brackets (use % instead)
let g:loaded_matchparen=1

" Cursor configuration
set guicursor=n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20  " Modern cursor shapes

" Status bar configuration
set title
set titleold="yeet 69 420"
set titlestring=%F
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Better display for messages
set cmdheight=2

" Smooth scrolling (Neovim 0.9+)
set smoothscroll  " NEOVIM 0.9+: Smooth scrolling for wrapped lines

" Commented out - these are default in Neovim:
" syntax on       " NEOVIM: Default - syntax highlighting enabled
" set ruler       " NEOVIM: Default - shows cursor position  
" set laststatus=2 " NEOVIM: Default - always show statusline

" ================================================================================
" FOLDING
" ================================================================================

set foldmethod=indent    " Fold based on indentation
set foldlevelstart=99    " Start with all folds open

" ================================================================================
" COMPLETION AND WILDMENU
" ================================================================================

" Completion behavior
set completeopt=menu,menuone,noselect  " Better completion popup behavior

" Command-line completion
set wildoptions=pum  " NEOVIM: Use popup menu for command completion

" Completion messages
set shortmess+=c  " Don't give ins-completion-menu messages

" ================================================================================
" LSP AND DEVELOPMENT SETTINGS
" ================================================================================

" Sign column configuration
set signcolumn=yes:2  " Always show signcolumn with width of 2 to prevent text shifting

" Update time for better diagnostic experience
set updatetime=300  " Better experience for diagnostic messages (default is 4000)

" Better diff algorithms
set diffopt+=algorithm:histogram,indent-heuristic

" ================================================================================
" PERFORMANCE AND LARGE FILES
" ================================================================================

" Performance optimizations
set synmaxcol=300  " Don't syntax highlight extremely long lines

" ================================================================================
" UNDO AND HISTORY
" ================================================================================

" Persistent undo
set undofile        " NEOVIM: Persistent undo, saves undo history to file
set undolevels=10000  " More undo levels for better history

" ================================================================================
" SYSTEM INTEGRATION
" ================================================================================

" Shell configuration
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" Modeline support
set modeline     " Enable modeline processing
set modelines=10 " Check first/last 10 lines for modelines

" ================================================================================
" CUSTOM COMMANDS AND FUNCTIONS
" ================================================================================

" Utility commands
command! FixWhitespace :%s/\s\+$//e                    " Remove trailing whitespaces
command! -nargs=0 Sw w !sudo tee % > /dev/null         " Save file as root

" Text wrapping function
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

" ================================================================================
" LOCAL CONFIGURATION
" ================================================================================

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif