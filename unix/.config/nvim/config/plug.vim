" # vim-plug setup
let vimplug_exists=expand("~/.config/nvim/autoload/plug.vim")

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
if (g:editor_mode == "noplugin" || g:largeFile)
  finish
endif

" # pkgs to installed
" Required:
call plug#begin(expand('~/.config/nvim/plugged'))

" ## navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vifm/vifm.vim'
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

" ## appearance
Plug 'nvim-lualine/lualine.nvim'
Plug 'phha/zenburn.nvim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" ## utils
Plug 'alvan/vim-closetag'
Plug 'liuchengxu/vim-which-key'
Plug 'chaoren/vim-wordmotion'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

" ## general dev tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sheerun/vim-polyglot'

" ### sessions
Plug 'tpope/vim-obsession'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'

" ### markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown', {'for': ['markdown', 'md']}
Plug 'ellisonleao/glow.nvim'

" ## dev tools text editing
"linter
if (g:editor_mode == "textedit" || g:editor_mode == "ide")
  Plug 'dense-analysis/ale'
  "preview colours in file
  Plug 'gorodinskiy/vim-coloresque'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'md', 'vim-plug']}
endif

" ## dev tools ide
"lsp
if (g:editor_mode == "ide")
  Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': 'CocStart'}
  Plug 'airblade/vim-rooter', {'branch': 'release'}
  Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
endif

" ## other
Plug 'ludwig/split-manpage.vim'
Plug 'junegunn/goyo.vim'
Plug 'chrisbra/unicode.vim'
Plug 'dstein64/vim-startuptime'

call plug#end()

" Required:
filetype plugin indent on

"todo stop errs when lua plugins not loaded
lua << END
require('lualine').setup{options = {theme = require'lualine.themes.gruvbox'}}
require('ibl').setup()
require('glow').setup()
END

