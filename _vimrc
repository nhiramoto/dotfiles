" Global Settings {{{

filetype plugin indent on   " Enable filetype detection, filetype scripts & indent scripts

set autoread                " Auto-reload changed files
set encoding=utf-8          " Encode characters as utf-8
set fileencoding=utf-8      " Encode files as utf-8
set termencoding=utf-8      " Set encoding for terminal
set foldlevelstart=0        " By default collapse all folds
set foldmethod=marker       " Fold using markers
set gdefault                " Replace command is global by default
set ignorecase              " Ignore case in regex
set smartcase
set incsearch               " Enable incremental search
set iskeyword-=_            " Assume underscore as word delimiter
set nobackup                " Disable backup files creation
set nowritebackup           ""
set noswapfile              " Disable swap files creation
set clipboard=unnamedplus   " Use system clipboard
set splitbelow              " Create horizontal splits below current window
set splitright              " Create vertical split right current window
set showmatch
set laststatus=2
set number
set relativenumber
set fillchars+=vert:\┃
set ttyfast
set synmaxcol=200           " Max column width for syntax highlighting
set mouse=a                 " Enable mouse for all modes
set autoindent              " Autoindentation
set expandtab               " Replace tabs with spaces
set tabstop=4               " Number of spaces considered as tab
set softtabstop=4           " Width of tab
set shiftwidth=4            " Width of tab (autoindent)
set shiftround              " Only indent to multiple of shiftwidth
" display indentation guides
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×
set nojoinspaces            " Avoid double spaces when joining lines

" Highlight characters beyond the maximum width
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Highlights Styles in tex files
hi clear texItalStyle
hi clear texBoldStyle

" Set default TeX flavour
let g:tex_flavor = 'latex'

" Conceal
set conceallevel=1
set concealcursor="nc"
" Show double quotes in json files
let g:vim_json_syntax_conceal = 0

augroup Vimrc
    au!
    " Automatically reload files changed outside vim
    au FocusGained,BufEnter * :checktime

    " Update splits when the window is resized
    au VimResized * :wincmd =

    " Only show cursor line in current window and insert mode
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END

" }}}
