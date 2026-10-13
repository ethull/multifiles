# fzf-notes

Obsidian-like note-taking functionality for Vim using fzf.

## Installation

Already installed in your dotfiles at `unix/.vim/autoload/fzf_notes/`

## Configuration

```vim
" Set your notes directory (default: ~/Projects/markdown/notes)
let g:fzf_notes_dir = '~/Projects/markdown/notes'

" Tag format when adding first tag (default: 'list')
" 'list':   tags:\n  - tag1\n  - tag2
" 'inline': tags: tag1, tag2
" Note: If tags already exist, the existing format is preserved
let g:fzf_notes_tag_format = 'list'

" Disable default keybindings
let g:fzf_notes_no_mappings = 1
```

## Commands

### Tags

- `:Tags` - List all tags with counts, select to search files
- `:TagSearch <tag>` - Search files by specific tag
- `:TagAdd` - Add tag to current file's frontmatter

### Links (Markdown files only)

- `:WikiLinkInsert` - Insert wiki link via fzf picker
- `:LinksOnPage` - Show all links on current page
- `:Backlinks` - Find files linking to current file

## Keybindings

### Tags
- `<leader>nt` - List all tags (`:Tags`)
- `<leader>ta` - Add tag to file (`:TagAdd`)

### Links (Markdown files only)
- `gf` - Follow wiki link under cursor OR default gf behavior (smart!)
- `<leader>wl` - Insert wiki link (fzf picker in normal mode)
- `<leader>wl` - Wrap selection in `[[link]]` (visual mode)
- `<leader>ll` - List all links on page
- `<leader>bl` - Show backlinks to current file
- `[[` + `<C-x><C-u>` - Autocomplete wiki link (completefunc)

## Testing

### Tags
1. Open vim in any directory
2. Run `:Tags` - should show all tags from your notes
3. Press ENTER on a tag - should show files with that tag
4. Open a markdown file with frontmatter
5. Run `:TagAdd` - should add tag to frontmatter

### Links
1. Open a markdown file with wiki links like `[[note-name]]`
2. Put cursor on link, press `gf` - should open that note
3. Press `<leader>ll` - should list all links on page
4. Type `[[` then press `<C-x><C-u>` - should autocomplete note names
5. Press `<leader>wl` - should open fzf picker to insert link
6. Select text, press `<leader>wl` - should wrap in `[[...]]`
7. Run `:Backlinks` - should show files linking to current file

### gf Smart Detection
- `gf` on `[[wiki-link]]` → follows wiki link
- `gf` on regular file path → uses default vim gf
- Works seamlessly!

## Supported Frontmatter Formats

### List Format
```yaml
---
tags:
  - prj-aepc
  - prj-aepc/frontend-ui-change
---
```

### Inline Format
```yaml
---
tags: project-planning, usc-routine
---
```

Both formats are fully supported for reading and writing.

## File Structure

```
unix/.vim/
├── autoload/fzf_notes/
│   ├── tags.vim      # Tag parsing and search (~220 lines)
│   └── util.vim      # Shared utilities (~20 lines)
└── plugin/
    └── fzf_notes.vim # Commands and config (~50 lines)
```

## Next Features (Not Yet Implemented)

- Wiki links (follow `[[links]]`)
- Backlinks
- Session bookmarks with annotations
- Daily notes
- Links on page
