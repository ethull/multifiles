"" vim-plug setup
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

"skip loading plugins if: told to via config or file is too large
if (g:editor_mode == "noplugin" || g:largeFile)
  finish
endif

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

"" pkgs to installed
" Required:
call plug#begin(expand('~/.vim/plugged'))

""" navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vifm/vifm.vim'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

""" appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"get gvim colour schemes to work in terminal vim
Plug 'vim-scripts/CSApprox'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

""" utils
"Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
"Plug 'tpope/vim-commentary'
"Plug 'wellle/targets.vim'
"Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vim-which-key'

""" general dev tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
"lines show indentation, alternative to following for spaces :set list lcs=tab:\|\
Plug 'Yggdroot/indentLine'
"contains language packs
Plug 'sheerun/vim-polyglot'
"sessions
Plug 'tpope/vim-obsession'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
" markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown', {'for': ['markdown', 'md']}

""" dev tools text editing
"linter
if (g:editor_mode == "textedit" || g:editor_mode == "ide")
  Plug 'dense-analysis/ale'
"expand abbreviations
  Plug 'mattn/emmet-vim'
"snippets
  "Plug 'SirVer/ultisnips'
"predefined snippets
  Plug 'honza/vim-snippets'
"ctags
  "Plug 'majutsushi/tagbar'
  "Plug 'ludovicchabant/vim-gutentags'
"preview colours in file
  Plug 'gorodinskiy/vim-coloresque'
"markdown
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'md', 'vim-plug']}
endif

""" dev tools ide
"lsp
if (g:editor_mode == "ide")
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': 'CocStart'}
"auto set cwd to proj root dir
  Plug 'airblade/vim-rooter', {'branch': 'release'}
"latex
  Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
endif

""" other
Plug 'ludwig/split-manpage.vim'
Plug 'junegunn/goyo.vim'
"extend native interface to unicode
Plug 'chrisbra/unicode.vim'

call plug#end()

" Required:
filetype plugin indent on
