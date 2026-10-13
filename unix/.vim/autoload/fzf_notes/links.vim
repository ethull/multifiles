" fzf_notes/links.vim - Wiki link functions

" Extract wiki link at cursor position
" Returns: 'note-name' or '' if not on wiki link
function! s:extract_wiki_link_at_cursor() abort
  let line = getline('.')
  let col = col('.')

  " Find all [[...]] patterns in line
  let pattern = '\[\[\zs[^\]]\+\ze\]\]'
  let start = 0

  while 1
    let match = matchstrpos(line, pattern, start)
    if match[1] == -1
      break
    endif

    " Check if cursor is within this match
    " match[1] is start pos, match[2] is end pos (both 0-indexed)
    " But we need to account for the [[ prefix (2 chars)
    let link_start = match[1] - 2
    let link_end = match[2] + 2

    if col > link_start && col <= link_end
      return match[0]
    endif

    let start = match[2]
  endwhile

  return ''
endfunction

" Parse link into filename and optional header
" Input: 'note-name#header' or 'note-name'
" Output: ['note-name', 'header'] or ['note-name', '']
function! s:parse_wiki_link(link) abort
  let parts = split(a:link, '#')
  if len(parts) >= 2
    return [parts[0], join(parts[1:], '#')]
  else
    return [parts[0], '']
  endif
endfunction

" Find file path for wiki link
" Searches: 1) relative to current file, 2) root of notes dir, 3) recursively in notes dir
function! s:find_wiki_file(filename) abort
  let notes_dir = fzf_notes#util#notes_dir()
  let current_dir = expand('%:p:h')

  " Try 1: Relative to current file (same directory)
  let relative_file = current_dir . '/' . a:filename . '.md'
  if filereadable(relative_file)
    return relative_file
  endif

  " Try 2: Root of notes directory
  let root_file = notes_dir . '/' . a:filename . '.md'
  if filereadable(expand(root_file))
    return expand(root_file)
  endif

  " Try 3: Search recursively in notes directory
  let found = glob(notes_dir . '/**/' . a:filename . '.md', 0, 1)
  if !empty(found)
    return found[0]
  endif

  return ''
endfunction

" Jump to header in current file
function! s:jump_to_header(header) abort
  if empty(a:header)
    return
  endif

  " Search for markdown header (# Header, ## Header, etc.)
  let pattern = '^#\+\s\+' . escape(a:header, '.*[]\^$')

  " Try exact match first
  call cursor(1, 1)
  if search(pattern, 'cW') > 0
    normal! zz
    return
  endif

  " Try case-insensitive
  call cursor(1, 1)
  if search(pattern, 'cWi') > 0
    normal! zz
    return
  endif

  echo 'Header not found: ' . a:header
endfunction

" Open wiki link file
function! s:open_wiki_link(link) abort
  " Parse link: separate filename and header
  let [filename, header] = s:parse_wiki_link(a:link)

  " Find the file
  let filepath = s:find_wiki_file(filename)

  if !empty(filepath)
    " File exists - open it
    execute 'edit' filepath

    " Jump to header if specified
    call s:jump_to_header(header)
  else
    " File doesn't exist - ask to create
    let notes_dir = fzf_notes#util#notes_dir()
    let new_file = notes_dir . '/' . filename . '.md'

    let choice = confirm('Note "' . filename . '" does not exist. Create it?', "&Yes\n&No", 1)
    if choice == 1
      execute 'edit' new_file
      " Add basic frontmatter
      call append(0, [
        \ '---',
        \ 'tags:',
        \ '---',
        \ '',
        \ '# ' . filename,
        \ ''
        \ ])

      " If header specified, add it
      if !empty(header)
        call append(line('$'), ['', '## ' . header, ''])
      endif

      normal! G
    endif
  endif
endfunction

" Main function: Follow wiki link or fall back to default gf
function! fzf_notes#links#follow() abort
  " Try to extract wiki link at cursor
  let link = s:extract_wiki_link_at_cursor()

  if !empty(link)
    " Found wiki link - follow it
    call s:open_wiki_link(link)
  else
    " No wiki link - use default gf behavior
    normal! gf
  endif
endfunction

" Insert wiki link from fzf picker
function! fzf_notes#links#insert() abort
  let notes_dir = fzf_notes#util#notes_dir()
  let files = glob(notes_dir . '/**/*.md', 0, 1)

  if empty(files)
    echo 'No markdown files found in notes directory'
    return
  endif

  " Extract just the filename without path and extension
  let note_names = []
  for file in files
    let name = fnamemodify(file, ':t:r')
    call add(note_names, name)
  endfor

  call fzf#run(fzf#wrap({
    \ 'source': note_names,
    \ 'sink': function('s:insert_wiki_link_at_cursor'),
    \ 'options': [
    \   '--preview', 'cat ' . notes_dir . '/{}.md 2>/dev/null || echo "File not found"',
    \   '--preview-window', 'up:60%:wrap',
    \   '--header', 'Insert wiki link'
    \ ],
    \ 'down': '40%'
    \ }))
endfunction

function! s:insert_wiki_link_at_cursor(filename) abort
  " Insert at cursor position
  execute "normal! i[[" . a:filename . "]]"
endfunction

" Create wiki link from visual selection
function! fzf_notes#links#from_visual() range abort
  " Get visually selected text
  let saved_reg = @"
  normal! gvy
  let selected = @"
  let @" = saved_reg

  " Replace selection with [[selected]]
  execute "normal! gvc[[" . selected . "]]"
endfunction

" Complete wiki links (for completefunc)
function! fzf_notes#links#complete(findstart, base) abort
  if a:findstart
    " Find start of wiki link (after [[)
    let line = getline('.')
    let start = col('.') - 1

    " Look backwards for [[
    while start > 1
      if line[start - 2 : start - 1] ==# '[['
        return start
      endif
      let start -= 1
    endwhile

    return -1
  else
    " Return list of note names
    let notes_dir = fzf_notes#util#notes_dir()
    let files = glob(notes_dir . '/**/*.md', 0, 1)
    let names = []

    for file in files
      let name = fnamemodify(file, ':t:r')
      if name =~# '^' . a:base
        call add(names, name)
      endif
    endfor

    return names
  endif
endfunction

" Show all links on current page
function! fzf_notes#links#show_on_page() abort
  let links = []
  let lnum = 1

  for line in getline(1, '$')
    " Find all [[links]] in line
    let start = 0
    while 1
      let match = matchstrpos(line, '\[\[\zs[^\]]\+\ze\]\]', start)
      if match[1] == -1
        break
      endif

      call add(links, printf('%4d: %s', lnum, match[0]))
      let start = match[2]
    endwhile
    let lnum += 1
  endfor

  if empty(links)
    echo 'No wiki links found on this page'
    return
  endif

  call fzf#run(fzf#wrap({
    \ 'source': links,
    \ 'sink': function('s:jump_to_link_line'),
    \ 'options': [
    \   '--header', 'Links on this page (ENTER=jump, gf=follow)',
    \   '--preview-window', 'hidden'
    \ ]
    \ }))
endfunction

function! s:jump_to_link_line(line) abort
  " Extract line number and link name from format '  42: note-name'
  let lnum = str2nr(matchstr(a:line, '^\s*\d\+'))
  let link = matchstr(a:line, ':\s*\zs.*')

  " Jump to that line
  execute lnum

  " Position cursor on the link and follow it
  call search('\[\[', 'c', line('.'))

  " Follow the link
  call s:open_wiki_link(link)
endfunction

" Open backlink and force redraw to clear fzf artifacts
function! s:open_backlink(file) abort
  execute 'edit' a:file
  redraw!
endfunction

" Find backlinks (files linking to current file)
function! fzf_notes#links#backlinks() abort
  let current_file = expand('%:t:r')
  let notes_dir = fzf_notes#util#notes_dir()

  if empty(current_file)
    echo 'Current file has no name'
    return
  endif

  " Search for [[current_file]] or [[current_file#header]] in all notes
  let files = glob(notes_dir . '/**/*.md', 0, 1)
  let backlinks = []

  for file in files
    " Skip current file
    if expand('%:p') ==# file
      continue
    endif

    " Check if file contains link to current file (with or without header)
    let content = join(readfile(file), "\n")
    " Match: [[filename]] or [[filename#anything]]
    if content =~# '\[\[' . escape(current_file, '.*[]\^$') . '\(#[^\]]*\)\?\]\]'
      call add(backlinks, file)
    endif
  endfor

  if empty(backlinks)
    echo 'No backlinks found for: ' . current_file
    return
  endif

  call fzf#run(fzf#wrap({
    \ 'source': backlinks,
    \ 'sink': function('s:open_backlink'),
    \ 'options': [
    \   '--preview', 'cat {}',
    \   '--preview-window', 'up:60%:wrap',
    \   '--header', 'Backlinks to: ' . current_file . ' (' . len(backlinks) . ' files)'
    \ ]
    \ }))
endfunction
