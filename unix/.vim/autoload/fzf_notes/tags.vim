" fzf_notes/tags.vim - Tag management functions

" Parse tags from frontmatter YAML
" Supports two formats:
"   1. List format:    tags:\n  - tag1\n  - tag2
"   2. Inline format:  tags: tag1, tag2, tag3
" Returns: ['tag1', 'tag2', ...]
function! fzf_notes#tags#parse_file(filepath) abort
  let tags = []

  if !filereadable(expand(a:filepath))
    return tags
  endif

  let lines = readfile(expand(a:filepath))
  let in_frontmatter = 0
  let in_tags_block = 0

  for line in lines
    " Start of frontmatter
    if line =~# '^---\s*$'
      if !in_frontmatter
        let in_frontmatter = 1
        continue
      else
        " End of frontmatter
        break
      endif
    endif

    if !in_frontmatter
      continue
    endif

    " Tags line: "tags: tag1, tag2" or "tags:"
    if line =~# '^tags:\s*'
      let in_tags_block = 1

      " Check for inline format: "tags: tag1, tag2"
      let inline_tags = matchstr(line, '^tags:\s*\zs.*')
      if !empty(inline_tags)
        " Parse comma-separated tags
        for tag in split(inline_tags, ',')
          let tag = substitute(tag, '^\s*\|\s*$', '', 'g')
          if !empty(tag)
            call add(tags, tag)
          endif
        endfor
        let in_tags_block = 0
      endif
      continue
    endif

    " List format: "  - tag"
    if in_tags_block && line =~# '^\s*-\s*'
      let tag = matchstr(line, '^\s*-\s*\zs.*')
      let tag = substitute(tag, '^\s*\|\s*$', '', 'g')
      if !empty(tag)
        call add(tags, tag)
      endif
      continue
    endif

    " End of tags block (next key or empty line)
    if in_tags_block && line =~# '^\w\+:'
      let in_tags_block = 0
    endif
  endfor

  return tags
endfunction

" Get all tags from all notes with counts
" Returns: {'tag1': 5, 'tag2': 3, ...}
function! fzf_notes#tags#get_all() abort
  let notes_dir = fzf_notes#util#notes_dir()
  let files = glob(notes_dir . '/**/*.md', 0, 1)
  let tag_counts = {}

  for file in files
    let tags = fzf_notes#tags#parse_file(file)
    for tag in tags
      let tag_counts[tag] = get(tag_counts, tag, 0) + 1
    endfor
  endfor

  return tag_counts
endfunction

" Format tags for fzf display
" Input: {'tag1': 5, 'tag2': 3}
" Output: ['  5  tag1', '  3  tag2']
function! s:format_tags_for_fzf(tag_counts) abort
  let formatted = []

  for [tag, cnt] in items(a:tag_counts)
    call add(formatted, printf('%3d  %s', cnt, tag))
  endfor

  " Sort by count descending
  call sort(formatted, {a, b -> str2nr(matchstr(b, '^\s*\d\+')) - str2nr(matchstr(a, '^\s*\d\+'))})

  return formatted
endfunction

" Extract tag from fzf formatted line
" Input: '  5  prj-aepc'
" Output: 'prj-aepc'
function! s:extract_tag(line) abort
  return substitute(a:line, '^\s*\d\+\s\+', '', '')
endfunction

" FZF sink: search files by selected tag
function! s:tag_list_sink(line) abort
  let tag = s:extract_tag(a:line)
  call fzf_notes#tags#search(tag)
endfunction

" Show all tags in fzf picker
function! fzf_notes#tags#show_all() abort
  let tag_counts = fzf_notes#tags#get_all()

  if empty(tag_counts)
    echo 'No tags found in notes'
    return
  endif

  let source = s:format_tags_for_fzf(tag_counts)

  call fzf#run(fzf#wrap({
    \ 'source': source,
    \ 'sink': function('s:tag_list_sink'),
    \ 'options': [
    \   '--header', 'All Tags (ENTER=search files with tag)',
    \   '--preview-window', 'hidden'
    \ ]
    \ }))
endfunction

" Search files by tag
function! fzf_notes#tags#search(tag) abort
  let notes_dir = fzf_notes#util#notes_dir()
  let files = glob(notes_dir . '/**/*.md', 0, 1)
  let matching_files = []

  for file in files
    let tags = fzf_notes#tags#parse_file(file)
    if index(tags, a:tag) >= 0
      call add(matching_files, file)
    endif
  endfor

  if empty(matching_files)
    echo 'No files found with tag: ' . a:tag
    return
  endif

  call fzf#run(fzf#wrap({
    \ 'source': matching_files,
    \ 'sink': 'edit',
    \ 'options': [
    \   '--preview', 'cat {}',
    \   '--preview-window', 'up:60%:wrap',
    \   '--header', 'Files tagged: ' . a:tag . ' (' . len(matching_files) . ' files)'
    \ ]
    \ }))
endfunction

" Add tag to current file's frontmatter
function! fzf_notes#tags#add() abort
  " Get all existing tags for picker
  let all_tags = keys(fzf_notes#tags#get_all())

  if empty(all_tags)
    " No existing tags, just prompt for new
    let tag = input('Enter new tag: ')
    if !empty(tag)
      call s:insert_tag_into_frontmatter(tag)
    endif
    return
  endif

  call fzf#run(fzf#wrap({
    \ 'source': all_tags,
    \ 'sink': function('s:insert_tag_into_frontmatter'),
    \ 'options': [
    \   '--header', 'Select tag to add (or type new and press ENTER)',
    \   '--print-query'
    \ ],
    \ 'down': '40%'
    \ }))
endfunction

" Insert tag into current file's frontmatter
function! s:insert_tag_into_frontmatter(tag) abort
  " Handle fzf multi-line output (query + selection)
  let tag = type(a:tag) == v:t_list ? a:tag[-1] : a:tag
  let tag = substitute(tag, '^\s*\|\s*$', '', 'g')

  if empty(tag)
    return
  endif

  " Find frontmatter bounds
  let frontmatter_start = -1
  let frontmatter_end = -1
  let tags_line = -1

  for lnum in range(1, line('$'))
    let line = getline(lnum)

    if line =~# '^---\s*$'
      if frontmatter_start == -1
        let frontmatter_start = lnum
      else
        let frontmatter_end = lnum
        break
      endif
    endif

    if frontmatter_start > 0 && line =~# '^tags:\s*'
      let tags_line = lnum
    endif
  endfor

  " Case 1: No frontmatter - create it using configured format
  if frontmatter_start == -1
    let format = get(g:, 'fzf_notes_tag_format', 'list')

    if format ==# 'list'
      call append(0, [
        \ '---',
        \ 'tags:',
        \ '  - ' . tag,
        \ '---',
        \ ''
        \ ])
    else
      call append(0, [
        \ '---',
        \ 'tags: ' . tag,
        \ '---',
        \ ''
        \ ])
    endif

    echo 'Created frontmatter with tag: ' . tag
    return
  endif

  " Case 2: Frontmatter exists but no tags - add tags line using configured format
  if tags_line == -1
    let format = get(g:, 'fzf_notes_tag_format', 'list')

    if format ==# 'list'
      call append(frontmatter_start, ['tags:', '  - ' . tag])
    else
      call append(frontmatter_start, 'tags: ' . tag)
    endif

    echo 'Added tag: ' . tag
    return
  endif

  " Case 3: Tags exist - detect and match existing format
  let tags_line_content = getline(tags_line)

  " Check format: inline or list
  if tags_line_content =~# '^tags:\s*$'
    " List format - add as new item
    call append(tags_line, '  - ' . tag)
  else
    " Inline format - append with comma
    call setline(tags_line, tags_line_content . ', ' . tag)
  endif

  echo 'Added tag: ' . tag
endfunction
