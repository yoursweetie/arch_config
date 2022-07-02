filetype on
" map <SPACE> <nop>
map s <nop>
map S :w<CR>
map Q :q<CR>

" in normal model keyboard mapping:
" noremap <silent> ; l
" noremap <silent> l h
noremap <silent> J 5j
noremap <silent> K 5k
noremap <silent> W 5w
noremap <silent> B 5b
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
call plug#begin('~/.vim/plugged')

" fzf
Plug 'gfanto/fzf-lsp.nvim'

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

" show git branch on air-line
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

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_text_changed = 1
let g:ale_lint_on_enter = 0

let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}

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

nmap <silent> <LEADER>r <Plug>(coc-references)

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
call plug#end()

"===
"===Appearence
"===
colorscheme gruvbox
" colorscheme onedark
" gruvbox 主题会在light和dark随意切换,就设置了全部是dark:
set background=dark
" 下面两条指令使背景透明
let g:gruvbox_transparent_bg = 1
autocmd VimEnter * hi Normal ctermbg=none


"===
"===auto fcitx5
"===
let g:input_toggle = 1
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
" autocmd InsertEnter * call Fcitx52zh()

"===
"===remember last cursorline
"===
augroup resCur
  autocmd!
  autocmd BufReadPost * call setpos(".", getpos("'\""))
augroup END

" auto generate comment info
" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"
" 加入注释
func SetComment()
    call setline(1,"/*")
    call append(line("."),   " *  Copyright (C) ".strftime("%Y")." GPL")
    call append(line(".")+1, " *")
    call append(line(".")+2, " *  File   : ".expand("%:t"))
    call append(line(".")+3, " *  Author : ziya")
    call append(line(".")+4, " *  Date   : ".strftime("%Y-%m-%d"))
    call append(line(".")+5, " *  Comment:")
    call append(line(".")+6, " *")
    call append(line(".")+7, " */")
    call append(line(".")+8, "")
endfunc
" 加入shell,Makefile注释
func SetComment_sh()
    call setline(3, "#================================================================")
    call setline(4, "#  Copyright (C) ".strftime("%Y")." GPL")
    call setline(5, "#")
    call setline(6, "#  File   :".expand("%:t"))
    call setline(7, "#  Author : ziya")
    call setline(8, "#  Date   : ".strftime("%Y-%m-%d"))
    call setline(9, "#  Comment:")
    call setline(10, "#")
    call setline(11, "#================================================================")
    call setline(12, "")
endfunc
" 定义函数SetTitle，自动插入文件头
func SetTitle()
    if &filetype == 'make'
        call setline(1,"")
        call setline(2,"")
        call SetComment_sh()

    elseif &filetype == 'sh'
        call setline(1,"#!/bin/bash")
        call setline(2,"")
        call SetComment_sh()

    else
        call SetComment()
        if expand("%:e") == 'hpp'
            call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
            call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
            call append(line(".")+12, "#ifdef __cplusplus")
            call append(line(".")+13, "extern \"C\"")
            call append(line(".")+14, "{")
            call append(line(".")+15, "#endif")
            call append(line(".")+16, "")
            call append(line(".")+17, "#ifdef __cplusplus")
            call append(line(".")+18, "}")
            call append(line(".")+19, "#endif")
            call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

        elseif expand("%:e") == 'h'
            call append(line(".")+10, "#pragma once")
        elseif &filetype == 'c'
            call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")
        elseif &filetype == 'cpp'
            call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")
        endif
    endif
endfunc
