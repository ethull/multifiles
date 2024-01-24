" # vim-plug setup
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" skip loading plugins if: told to via config or file is too large
if ( g:load_plugins != 1 || g:largeFile)
  finish
endif

" # pkgs to installed
" Required:
call plug#begin(expand('~/.vim/plugged'))

if index(g:plugin_groups, "light") >= 0
  Plug 'chaoren/vim-wordmotion'
  Plug 'scrooloose/nerdtree'
  Plug 'jistr/vim-nerdtree-tabs'
  Plug 'vifm/vifm.vim'
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
  endif

  "Plug 'vim-airline/vim-airline'
  "Plug 'vim-airline/vim-airline-themes'
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

  Plug 'alvan/vim-closetag'
  Plug 'liuchengxu/vim-which-key'

  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'

  Plug 'Yggdroot/indentLine'
  Plug 'sheerun/vim-polyglot'

  Plug 'tpope/vim-obsession'
  Plug 'xolox/vim-misc'
  Plug 'xolox/vim-session'
  "Plug 'zefei/vim-wintabs'
  "Plug 'dosimple/workspace.vim'

  Plug 'godlygeek/tabular'
  Plug 'preservim/vim-markdown', {'for': ['markdown', 'md']}

  Plug 'ludwig/split-manpage.vim'
  Plug 'junegunn/goyo.vim'
  Plug 'chrisbra/unicode.vim'
  Plug 'dstein64/vim-startuptime'
endif

if index(g:plugin_groups, "textedit") >= 0
  Plug 'dense-analysis/ale'
  Plug 'mattn/emmet-vim'
  "Plug 'SirVer/ultisnips'
  "Plug 'honza/vim-snippets'
  Plug 'gorodinskiy/vim-coloresque'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'md', 'vim-plug']}
  Plug 'jclsn/glow.vim'
endif

if index(g:plugin_groups, "ide") >= 0
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': 'CocStart'}
  Plug 'airblade/vim-rooter', {'branch': 'release'}
  Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
endif

call plug#end()

" Required:
filetype plugin indent on
