" Global Settings {{{

filetype plugin indent on   " Enable filetype detection, filetype scripts & indent scripts
let g:python_host_prog='/usr/bin/python'

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
" set matchpairs+=<:>         " Show matching angle brackets <>'s
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

" convert tabs to spaces when reading file
"autocmd! bufreadpost * set expandtab | retab! 4

" convert tabs to spaces before writing file
"autocmd! bufwritepre * set expandtab | retab! 4

" Highlights Styles in tex files
hi clear texItalStyle
hi clear texBoldStyle

" Set default TeX flavour
let g:tex_flavor = 'latex'

" Commentaries in italic mode
hi Comment cterm=italic

" Conceal
set conceallevel=1
set concealcursor="nc"
" Show double quotes in json files
let g:vim_json_syntax_conceal = 0

" nvim vs vim configurations
if has('nvim')
    " Neovim specific commands
    " set termguicolors
else
    " Standard vim specific commands
    set nocompatible " Use Vim's improvements
endif

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

" Keymaps {{{

" Save and Quit Keybindings
map <C-s> :w<CR>
map <C-q> :qa<CR>

" Clear Search Highlights
nnoremap <Esc> :nohl<cr>

" Toggle fold at current line
nnoremap <Tab> za

" Navigate without a prefix
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Go up and down visual lines (not logical lines, wrap text)
nnoremap j gj
nnoremap k gk

" Yank to end of line
noremap Y y$

nnoremap ! :!

nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Move lines around
nnoremap <Leader>k :m-2<CR>==
nnoremap <Leader>j :m+<CR>==
xnoremap <Leader>k :m-2<CR>gv=gv
xnoremap <Leader>j :m'>+<CR>gv=gv

" Keep search matches in the middle of screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Cursor line to the center of screen
nnoremap <C-m> zz

" Command mode mapping
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" Use <Tab> and <S-Tab> to move between matches
" cnoremap <expr> <Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>/<C-r>/' : '<C-z>'
" cnoremap <expr> <S-Tab> getcmdtype() == '/' \|\| getcmdtype() == '?' ? '<CR>?<C-r>/': '<S-Tab>'

" Open typora for markdown preview
autocmd FileType markdown noremap <silent> <C-m> :exec 'silent !typora "%" &'<cr>

" }}}

" Abbreviations {{{

" iabbrev {lhs} {rhs}

" }}}

" Language Settings {{{

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

map <F6> :setlocal spell! spelllang=en_us<CR>

" }}}

" Plugins {{{

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
" Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
Plugin 'mattn/emmet-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
Plugin 'raimondi/delimitmate'
" Plugin 'scrooloose/syntastic'
Plugin 'jshint/jshint'
" Plugin 'ap/vim-css-color'
" Plugin 'gko/vim-coloresque'
" Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'ciaranm/inkpot'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'sheerun/vim-wombat-scheme'
Plugin 'tomasr/molokai'
Plugin 'w0ng/vim-hybrid'
" Plugin 'Yggdroot/indentLine'
" Plugin 'bronson/vim-trailing-whitespace'
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'bling/vim-bufferline'
" Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
" Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'nlknguyen/papercolor-theme'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'romainl/Apprentice'
Plugin 'joshdick/onedark.vim'
" Plugin 'ying17zi/vim-live-latex-preview'
" Plugin 'ternjs/tern_for_vim'
Plugin 'severin-lemaignan/vim-minimap'
Plugin 'morhetz/gruvbox'
Plugin 'w0rp/ale'
Plugin 'chriskempson/base16-vim'
Plugin 'Reewr/vim-monokai-phoenix'
Plugin 'micha/vim-colors-solarized'
Plugin 'dag/vim-fish'
Plugin 'nhooyr/elysian.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'ryanoasis/vim-devicons'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'christoomey/vim-titlecase'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'christoomey/vim-tmux-runner'
Plugin 'editorconfig/editorconfig-vim'
" Plugin 'suan/vim-instant-markdown'
" Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'ayu-theme/ayu-vim'
Plugin 'junegunn/fzf.vim'
Plugin 'khzaw/vim-conceal'
Plugin 'mtth/scratch.vim'

set runtimepath^=~/.vim/bundle/vim-snippets
set runtimepath^=~/.vim/after/my-snippets

call vundle#end()
filetype plugin indent on

" }}}

" Color Scheme {{{

" Gruvbox theme
"let g:gruvbox_contrast_dark = 'medium'
"let g:gruvbox_termcolors=16

" Ayu theme
"let ayucolor="mirage"

syntax on
set background=dark
set cursorline
set hlsearch
set ruler
set t_Co=256
colorscheme apprentice

" }}}

" Plugin: Airline {{{

let g:airline_detect_modified = 1
let g:airline_inactive_collapse = 1
let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='wombat'
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}'
let g:airline_section_z = '%2l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%2v'

" }}}

" Plugin: Syntastic {{{
" let g:syntastic_check_on_open=1
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_jshint_exec='/usr/sbin/jshint'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_wq = 0
" }}}

" Plugin: NERDTree {{{
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinPos = 'left'
let NERDTreeShowHidden=1
" }}}

" Plugin: NERDCommenter {{{
" let g:NERDScapeDelims = 1
" let g:NERDCompactSexyComs = 1
" let g:NERDDefaultAlign = 'left'
" let g:NERDCommentEmptyLines = 1
" let g:NERDTrimTrailingWhitespace = 1
" }}}

" Plugin: Rainbow Parentheses {{{
"let g:rbpt_colorpairs = [
"        \ ['blue',       '#FF6000'],
"        \ ['cyan', '#00FFFF'],
"        \ ['darkmagenta',    '#CC00FF'],
"        \ ['yellow',   '#FFFF00'],
"        \ ['red',     '#FF0000'],
"        \ ['darkgreen',    '#00FF00'],
"        \ ['White',         '#c0c0c0'],
"        \ ['blue',       '#FF6000'],
"        \ ['cyan', '#00FFFF'],
"        \ ['darkmagenta',    '#CC00FF'],
"        \ ['yellow',   '#FFFF00'],
"        \ ['red',     '#FF0000'],
"        \ ['darkgreen',    '#00FF00'],
"        \ ['White',         '#c0c0c0'],
"        \ ['blue',       '#FF6000'],
"        \ ['cyan', '#00FFFF'],
"        \ ['darkmagenta',    '#CC00FF'],
"        \ ['yellow',   '#FFFF00'],
"        \ ['red',     '#FF0000'],
"        \ ['darkgreen',    '#00FF00'],
"        \ ['White',         '#c0c0c0'],
"        \ ]
"
"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
" }}}

" Plugin: Indent Lines {{{
" let g:indentLine_color_term = 236
" let g:indentLine_char = '¦'
" let g:indentLine_leadingSpaceEnabled = 1
" let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_setConceal = 2
" let g:indentLine_fileTypeExclude = ['json', 'md']
" }}}

" Plugin: CtrlP {{{
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_show_hidden = 1
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
" }}}

" Plugin: Multiple Cursors {{{
let g:multi_cursor_use_default_mapping=0
" Map start key separately from next key
"let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_next_key='*'
let g:multi_cursor_prev_key='#'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
" }}}

" Plugin: Minimap {{{
"let g:minimap_show='<leader>ms'
"let g:minimap_update='<leader>mu'
"let g:minimap_close='<leader>gc'
"let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'
" }}}

" Plugin: js-beautify {{{
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
" }}}

" Plugin: VTR - Vim Tmux Runner {{{
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
" }}}

" Plugin: fzf {{{
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_command_prefix = 'Fzf'
nnoremap <C-t> :FzfFiles<CR>
" }}}

" Plugin: vim-instant-markdown {{{
" let g:instant_markdown_autostart = 1 " Autostart
" let g:instant_markdown_open_to_the_world = 0 " Allow remote connection?
" let g:instant_markdown_allow_unsafe_content = 0 " Allow scripts to run?
" let g:instant_markdown_allow_external_content = 1 " Allow external content such as images, stylesheets and frames
" }}}

" Plugin: vim-markdown-preview {{{
" let vim_markdown_preview_hotkey='<C-m>'
" let vim_markdown_preview_browser=''
" let vim_markdown_preview_pandoc=0
" let vim_markdown_preview_use_xdg_open=1
" }}}

" Plugin: UltiSnips {{{

let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
let g:UltiSnipsSnippetsDir='~/.vim/UltiSnips'

" }}}

" Plugin: delimitMate {{{ 

let delimitMate_matchpairs = "(:),[:],{:}"

" }}}

" Custom Functions {{{

" Toggle Relative Numbers
function! ToggleRelativeNumbers()
    if (&relativenumber == 1)
        set number
        set relativenumber!
    else
        set relativenumber
    endif
endfunc
nnoremap <Leader>r :call ToggleRelativeNumbers()<CR>

" }}}

