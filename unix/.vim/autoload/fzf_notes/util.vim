" fzf_notes/util.vim - Shared utility functions

" Get notes directory from config or default
function! fzf_notes#util#notes_dir() abort
  return expand(get(g:, 'fzf_notes_dir', '~/Projects/markdown/notes'))
endfunction

" Get current session name (for bookmarks later)
function! fzf_notes#util#session_name() abort
  if exists('v:this_session') && v:this_session != ''
    return fnamemodify(v:this_session, ':t:r')
  endif
  return ''
endfunction

" Get session directory
function! fzf_notes#util#session_dir() abort
  return expand(get(g:, 'session_directory', '~/.vim/session'))
endfunction
