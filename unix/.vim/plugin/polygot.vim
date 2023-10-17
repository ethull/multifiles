" Syntax highlight

" default highlight is better than polyglot
" latex-box not needed as vimtex used
"let g:polyglot_disabled = ['python', 'latex']
let python_highlight_all = 1

let g:vim_json_syntax_conceal = 0

"vim markdown rm conceal and allow frontmatter
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
