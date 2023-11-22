" if we arent using vscode, load plugins
if ! exists('g:vscode')

  " get filesize, so we dont load plugins when editing very large files
  " file is large from 10mb
  let g:largeFileSize = 1024 * 1024 * 10
  "let g:largeFile = getfsize(expand("<afile>")) > g:largeFileSize
  let g:largeFile = getfsize(expand("%:p")) > g:largeFileSize

  source ~/.vim/config/config_manual.vim
  if filereadable(expand("~/.config/nvim/config/plug.vim"))
    source ~/.config/nvim/config/plug.vim
  else
    filetype plugin indent on
  endif
endif

if filereadable(expand("~/.config/nvim/config/general.vim"))
  source ~/.config/nvim/config/general.vim
endif
if filereadable(expand("~/.config/nvim/config/keybindings.vim"))
  source ~/.config/nvim/config/keybindings.vim
endif
