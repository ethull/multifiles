" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

" do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

" remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" disable settings for faster loading of large files
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

" setup lesspipe: for non-text files
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
" use lesspipe for pdf 
autocmd Filetype pdf
      \ exe '%!' . s:lesspipe_cmd . ' ' . expand('%:S') |
      \ setlocal filetype=text nomodifiable readonly |
