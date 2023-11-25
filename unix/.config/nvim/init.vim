" source editor mode and plugin groups
source ~/.config/nvim/config/config_manual.vim

" update plugin groups if we are in vscode
if exists('g:vscode')
  g:plugin_groups = ["vscode"]
endif

" noplugin if filesize is too big (> 10mb)
let g:largeFileSize = 1024 * 1024 * 10
let g:largeFile = getfsize(expand("%:p")) > g:largeFileSize

" load plugins
if filereadable(expand("~/.config/nvim/config/plug.vim"))
  source ~/.config/nvim/config/plug.vim
else
  filetype plugin indent on
endif

" load general settings
if filereadable(expand("~/.config/nvim/config/general.vim"))
  source ~/.config/nvim/config/general.vim
endif

" load keybindings
if filereadable(expand("~/.config/nvim/config/keybindings.vim"))
  source ~/.config/nvim/config/keybindings.vim
endif
