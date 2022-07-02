filetype plugin indent on
" map <SPACE> <nop>
map s K
map S :w<CR>
map Q :q<CR>

" in normal model keyboard mapping:
" noremap <silent> ; l
" noremap <silent> l h
noremap <silent> J 5j
noremap <silent> K 5k
" noremap <silent> W 5w
" noremap <silent> B 5b
noremap <C-j> <Esc>0i
noremap <C-k> <Esc>$a

" in insert model keyboard mapping:
imap <C-j> <Esc>0i
imap <C-k> <Esc>$a


" map <LEADER>p "+p
" map <LEADER>y "+y

" set <LEADER> as <SPACE>
let mapleader=" "

" search words
map <silent> <LEADER><CR> :nohlsearch<CR>

" ==<silent> =
" ==<silent> =Window management
" ==<silent> =
" use <LEADER> + new arrow keys for moving the cursor around windows
map <silent> <LEADER>w <C-w>W
map <silent> <LEADER>j <C-w>j
map <silent> <LEADER>k <C-w>k
map <silent> <LEADER>h <C-w>h
map <silent> <LEADER>l <C-w>l

" navigate buffers
noremap <silent> [b :bprevious<CR>
noremap <silent> ]b :bnext<CR>
noremap <silent> [B :bfirst<CR>
noremap <silent> ]B :blast<CR>

" compile & run cppfile
map <F9> :!g++ -std=c++11 -O2 -Wall % -o %<<CR>
" map <F8> :!time ./%<<CR>
map <F8> :!time ./%<<CR>

" compile&run
map <F12> :call CompileRun()<CR>

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec '!gcc -O2 -Wall % -o %<'
    exec '!./%<'
elseif &filetype == 'cpp'
    exec '!g++ -std=c++11 -O2 -Wall % -o %<'
    exec '!./%<'
elseif &filetype == 'cc'
    exec '!g++ -std=c++11 -O2 -Wall % -o %<'
    exec '!./%<'
elseif &filetype == 'python'
    exec '!python %'
elseif &filetype == 'sh'
    exec '!zsh %'
endif
endfunc

set updatetime=100
set encoding=utf-8
" when file has been changed, autoread
set autoread
set number
set cursorline
set relativenumber
set t_Co=256
filetype indent on
set autoindent
set expandtab
set softtabstop=4
set tabstop=4
" 使o换行时,自动缩进4空格,否则为8空格
set shiftwidth=4
set noswapfile
set listchars=tab:>-,trail:■
set list
set wrap
set showcmd
set wildmenu
" 搜索时忽略大小写
set ignorecase
set hlsearch
exec "nohlsearch"
" 使底部或顶部至少显示5行
set scrolloff=5
" code fold manual
set foldmethod=manual
set mouse=a
" 水平开新的窗口时放在下方
set splitbelow
" vertical时直接跳到新的右边的窗口
set splitright


" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.vim/plugged')
call plug#begin('~/.config/nvim/plugged')

" Make sure you use single quotes

" a vim themes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'connorholyday/vim-snazzy'

" vim-ariline
Plug 'vim-airline/vim-airline'
let g:airline#extensions#hunks#enabled=0
let g:airline#extensions#branch#enabled=1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = '|'

" show branch on vim-airline
Plug 'tpope/vim-fugitive'

"auto-pairs
Plug 'jiangmiao/auto-pairs'

" nerdtree
Plug 'preservim/nerdtree'
nnoremap <C-n> :NERDTree<CR>
" turn off ugly arrows
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''

" Start NERDTree. If a file is specified, move the cursor to its window."
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" like a git status
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusIndicatorMapCustom = {
                    \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \}

" nerdtree icons
Plug 'ryanoasis/vim-devicons'
let g:DevIconsEnableFoldersOpenClose = 1

" ale
Plug 'dense-analysis/ale'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0

" let g:ale_sign_error = '!'
" let g:ale_sign_warning = '?'
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

" let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 0

let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\}
" \   'python': ['pylint'],

" coc.nvim
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Use tab for trigger completion with characters ahead and navigate.
 " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
 " other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <LEADER>f to show documentation in preview window.
nnoremap <silent> <LEADER>f :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" select a word and mark other same words
Plug 'RRethy/vim-illuminate'

" code comment
Plug 'preservim/nerdcommenter'
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/*','right': '*/'  }  }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" 右侧整体预览
Plug 'wfxr/code-minimap'
Plug 'wfxr/minimap.vim'
let g:minimap_auto_start = 0

" let g:minimap_width = 10

" show file change(+, ...)
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" indent
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1
" consider spaces as indention
let g:indent_guides_space_guides = 1
" not consider tab as indent
let g:indent_guides_tab_guides = 0

" nvim icons
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" let g:nvim_tree_side = 'right' "left by default
" let g:nvim_tree_width = 35 "30 by default
" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_auto_open = 1 "0 by default, opens the tree when typing `vim $DIR` or `vim`
" let g:nvim_tree_auto_close = 0 "0 by default, closes the tree when it's the last window
" let g:nvim_tree_auto_ignore_ft = [ 'startify', 'dashboard' ] "empty by default, don't auto open tree on specific filetypes.
" let g:nvim_tree_quit_on_open = 0 "0 by default, closes the tree when you open a file
" let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
" let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
" let g:nvim_tree_hide_dotfiles = 0 "0 by default, this option hides files and folders starting with a dot `.`
" let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
" let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
" let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
" let g:nvim_tree_width_allow_resize  = 1 "0 by default, will not resize the tree when opening a file
" let g:nvim_tree_disable_netrw = 0 "1 by default, disables netrw
" let g:nvim_tree_hijack_netrw = 0 "1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
" let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
" let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
" let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
" let g:nvim_tree_special_files = [ 'README.md', 'Makefile', 'MAKEFILE' ] " List of filenames that gets highlighted with NvimTreeSpecialFile
" let g:nvim_tree_show_icons = {
"     \ 'git': 1,
"     \ 'folders': 1,
"     \ 'files': 1,
"     \ }
" "If 0, do not show the icons for one of 'git' 'folder' and 'files'
" "1 by default, notice that if 'files' is 1, it will only display
" "if nvim-web-devicons is installed and on your runtimepath
" 
" " default will show icon by default if no icon is provided
" " default shows no icon by default
" let g:nvim_tree_icons = {
"     \ 'default': '',
"     \ 'symlink': '',
"     \ 'git': {
"     \   'unstaged': "✗",
"     \   'staged': "✓",
"     \   'unmerged': "",
"     \   'renamed': "➜",
"     \   'untracked': "★",
"     \   'deleted': "",
"     \   'ignored': "◌"
"     \   },
"     \ 'folder': {
"     \   'default': "",
"     \   'open': "",
"     \   'empty': "",
"     \   'empty_open': "",
"     \   'symlink': "",
"     \   'symlink_open': "",
"     \   },
"     \   'lsp': {
"     \     'hint': "",
"     \     'info': "",
"     \     'warning': "",
"     \     'error': "",
"     \   }
"     \ }

" nnoremap <silent> <C-n> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen and NvimTreeClose are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue
" -- following options are the default
" -- each of these are documented in `:help nvim-tree.OPTION_NAME`
" require'nvim-tree'.setup {
"   disable_netrw       = true,
"   hijack_netrw        = true,
"   open_on_setup       = false,
"   ignore_ft_on_setup  = {},
"   auto_close          = false,
"   open_on_tab         = false,
"   hijack_cursor       = false,
"   update_cwd          = false,
"   update_to_buf_dir   = {
"     enable = true,
"     auto_open = true,
"   },
"   diagnostics = {
"     enable = false,
"     icons = {
"       hint = "",
"       info = "",
"       warning = "",
"       error = "",
"     }
"   },
"   update_focused_file = {
"     enable      = false,
"     update_cwd  = false,
"     ignore_list = {}
"   },
"   system_open = {
"     cmd  = nil,
"     args = {}
"   },
"   filters = {
"     dotfiles = false,
"     custom = {}
"   },
"   git = {
"     enable = true,
"     ignore = true,
"     timeout = 500,
"   },
"   view = {
"     width = 30,
"     height = 30,
"     hide_root_folder = false,
"     side = 'left',
"     auto_resize = false,
"     mappings = {
"       custom_only = false,
"       list = {}
"     },
"     number = false,
"     relativenumber = false,
"     signcolumn = "yes"
"   },
"   trash = {
"     cmd = "trash",
"     require_confirm = true
"   }
" }


" fzf
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'

" dashboard
" Plug 'glepnir/dashboard-nvim'
" let g:dashboard_default_executive='fzf'

" markdown preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 0

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 1

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = '/usr/bin/chromium'

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']


call plug#end()

"===
"===Appearence
"===
colorscheme gruvbox
" colorscheme snazzy
" colorscheme onedark
" gruvbox 主题会在light和dark随意切换,就设置了全部是dark:
set background=dark
" 下面两条指令使背景透明
let g:gruvbox_transparent_bg = 1
autocmd VimEnter * hi Normal ctermbg=none


"===
"===auto fcitx5
"===
let g:input_toggle = 0
function! Fcitx52en()
   let s:input_status = system("fcitx5-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx5-remote -c")
   endif
endfunction

function! Fcitx52zh()
   let s:input_status = system("fcitx5-remote")
   if s:input_status != 2 && g:input_toggle == 1
      let l:a = system("fcitx5-remote -o")
      let g:input_toggle = 0
   endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx52en()
"进入插入模式
autocmd InsertEnter * call Fcitx52zh()

"===
"===remember last cursorline
"===
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END
