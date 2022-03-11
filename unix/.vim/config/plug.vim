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
""" dev tools
"""" multi-language specific features
""""" async linter, optionally basic lsp client
if (g:editor_mode == "textedit" || g:editor_mode == "ide")
  Plug 'dense-analysis/ale'
endif
""""" versatile lsp client
if (g:editor_mode == "ide")
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif
""""" auto set cwd to proj root dir
if (g:editor_mode == "ide")
  Plug 'airblade/vim-rooter', {'branch': 'release'}
endif
""""" expand abbreviations
Plug 'mattn/emmet-vim'
""""" snippets
" Plug 'SirVer/ultisnips'
"predefined snippets
Plug 'honza/vim-snippets'
"""" ctags
"sidebar that displays ctags-generated tags of the current file, ordered by their scope
"Plug 'majutsushi/tagbar'
"""" git
Plug 'tpope/vim-fugitive'
"required by fugitive to :Gbrowse
Plug 'tpope/vim-rhubarb'
"visual repersentation of git diff
Plug 'airblade/vim-gitgutter'
"""" programming util
Plug 'tpope/vim-surround'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-commentary'
"""" lines show indentation, alternative to following for spaces :set list lcs=tab:\|\
Plug 'Yggdroot/indentLine'
"""" contains language packs
Plug 'sheerun/vim-polyglot'
"""" highlight colors with actual colour //preview colours
Plug 'gorodinskiy/vim-coloresque'
"""" lang specific
""""" markdown
"Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
if (g:editor_mode == "textedit" || g:editor_mode == "ide")
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'md', 'vim-plug']}
endif
"Plug 'gabrielelana/vim-markdown'
"Plug 'vim-pandoc/vim-pandoc-syntax', {'for': ['markdown', 'md']}
Plug 'preservim/vim-markdown', {'for': ['markdown', 'md']}
""""" latex
if (g:editor_mode == "textedit" || g:editor_mode == "ide")
  Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
endif
""" vim-session
Plug 'tpope/vim-obsession'
""" other
Plug 'ludwig/split-manpage.vim'
"""" extend native interface to unicode
Plug 'chrisbra/unicode.vim'
"""" exe external cmds asyncronously
let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif   
Plug 'Shougo/vimproc.vim', {'do': g:make}
"""" leader key prompt/guide
Plug 'liuchengxu/vim-which-key'
"Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

"" Include user's extra bundle
if filereadable(expand("~/.vimrc.local.bundles"))
  source ~/.vimrc.local.bundles
endif

call plug#end()

" Required:
filetype plugin indent on
