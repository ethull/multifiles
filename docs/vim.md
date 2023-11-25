## nvim plugins

### conditional loading
> set load_plugins = 0 to not load any plugins

#### plugin groups
> add plugin group to plugin_groups to load plugins from that group
- vscode: only load plugins that work with vscode-neovim
- light: load a few plugins for light editing experience
- textedit: load plugins for text editing
- ide: load plugins for an ide experience

### plugin list
#### navigation
```
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vifm/vifm.vim'
Plug 'junegunn/fzf.vim'
```
#### appearance
- airline causes cursor issue in nvim
- new zenburn plugin for neovim
```
Plug 'nvim-lualine/lualine.nvim'
Plug 'phha/zenburn.nvim'
Plug 'luochen1990/rainbow'
```
#### utils
```
Plug 'alvan/vim-closetag'
Plug 'liuchengxu/vim-which-key'
"motion to move to camelcase and underscores
Plug 'chaoren/vim-wordmotion'
"switch buffers quickly
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'

Plug 'ludwig/split-manpage.vim'
Plug 'junegunn/goyo.vim'
"extend native interface to unicode
Plug 'chrisbra/unicode.vim'
Plug 'dstein64/vim-startuptime'
```
#### git / dev
```
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
"lines show indentation, alternative to following for spaces :set list lcs=tab:\|\
Plug 'lukas-reineke/indent-blankline.nvim'
"contains language packs
Plug 'sheerun/vim-polyglot'
```
#### sessions
```
Plug 'tpope/vim-obsession'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
```
#### markdown
```
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown', {'for': ['markdown', 'md']}
Plug 'ellisonleao/glow.nvim`'
```
#### other
```
Plug 'dense-analysis/ale'
"preview colours in file
Plug 'gorodinskiy/vim-coloresque'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'md', 'vim-plug']}

"lsp
Plug 'neoclide/coc.nvim', {'branch': 'release', 'on': 'CocStart'}
"auto set cwd to proj root dir
Plug 'airblade/vim-rooter', {'branch': 'release'}
"latex
Plug 'lervag/vimtex', {'for': ['tex', 'latex']}
```

### removed plugins
```
Plug 'vim-scripts/CSApprox'
```

### plugins to retry/try
```
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-sneak'
Plug 'wellle/targets.vim'
"expand abbreviations
Plug 'mattn/emmet-vim'
"snippets
Plug 'SirVer/ultisnips'
"predefined snippets
Plug 'honza/vim-snippets'
"ctags
Plug 'majutsushi/tagbar'
Plug 'ludovicchabant/vim-gutentags'
"markdown in terminal preview (doesnt support nvim)
"Plug 'jclsn/glow.vim'
```