" fzf_notes.vim - Obsidian-like note-taking with fzf and vim
" Maintainer: Personal use
" Version: 0.1.0

if exists('g:loaded_fzf_notes')
  finish
endif
let g:loaded_fzf_notes = 1

" Configuration
let g:fzf_notes_dir = get(g:, 'fzf_notes_dir', '~/Projects/markdown/notes')

" Tag format when adding first tag: 'list' or 'inline'
" 'list':   tags:\n  - tag1\n  - tag2
" 'inline': tags: tag1, tag2
let g:fzf_notes_tag_format = get(g:, 'fzf_notes_tag_format', 'list')

" ============================================================================
" Commands - Tags
" ============================================================================

" List all tags with counts, pick to search files
command! Tags call fzf_notes#tags#show_all()

" Search files by specific tag
command! -nargs=1 TagSearch call fzf_notes#tags#search(<q-args>)

" Add tag to current file's frontmatter
command! TagAdd call fzf_notes#tags#add()

" ============================================================================
" Commands - Search
" ============================================================================

" Grep notes sorted by filename descending (newest date-prefix first)
command! -bang -nargs=* RgN call s:rg_notes(<q-args>, <bang>0)

function! s:rg_notes(query, bang) abort
  let notes_dir = expand(g:fzf_notes_dir)
  let rg_base = 'rg --column --line-number --no-heading --color=always --smart-case --sortr path -- '
  let initial = rg_base . shellescape(a:query) . ' ' . notes_dir
  let reload  = rg_base . '{q} ' . notes_dir

  call fzf#vim#grep(initial, 1, fzf#vim#with_preview({
    \ 'options': [
    \   '--no-sort',
    \   '--phony',
    \   '--query', a:query,
    \   '--bind', 'change:reload:' . reload,
    \   '--delimiter', ':',
    \   '--with-nth', '1,4..',
    \ ]
    \ }), a:bang)
endfunction

" ============================================================================
" Commands - Links
" ============================================================================

" Insert wiki link via fzf picker
command! WikiLinkInsert call fzf_notes#links#insert()

" Show all links on current page
command! LinksOnPage call fzf_notes#links#show_on_page()

" Find backlinks (files linking to current file)
command! Backlinks call fzf_notes#links#backlinks()

" ============================================================================
" Keybindings (optional - can be disabled)
" ============================================================================

if !get(g:, 'fzf_notes_no_mappings', 0)
  " Tags
  nnoremap <leader>nt :Tags<CR>
  nnoremap <leader>ta :TagAdd<CR>

  " Links (in markdown files only)
  autocmd FileType markdown nnoremap <buffer> <leader>wl :WikiLinkInsert<CR>
  autocmd FileType markdown vnoremap <buffer> <leader>wl :call fzf_notes#links#from_visual()<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>ll :LinksOnPage<CR>
  autocmd FileType markdown nnoremap <buffer> <leader>bl :Backlinks<CR>

  " Override gf for markdown files (smart detection)
  autocmd FileType markdown nnoremap <buffer> gf :call fzf_notes#links#follow()<CR>

  " Set completefunc for wiki link autocomplete
  autocmd FileType markdown setlocal completefunc=fzf_notes#links#complete
endif
