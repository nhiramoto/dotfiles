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
set syntax=on

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

" Plugins {{{

filetype off

call plug#begin()

Plug 'joshdick/onedark.vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'SirVer/ultisnips'
Plug 'raimondi/delimitmate'
Plug 'jshint/jshint'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'ciaranm/inkpot'
Plug 'jonathanfilip/vim-lucius'
Plug 'chriskempson/vim-tomorrow-theme'
Plug 'sheerun/vim-wombat-scheme'
Plug 'tomasr/molokai'
Plug 'w0ng/vim-hybrid'
Plug 'bling/vim-bufferline'
Plug 'hail2u/vim-css3-syntax'
Plug 'cakebaker/scss-syntax.vim'
Plug 'nlknguyen/papercolor-theme'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'terryma/vim-multiple-cursors'
Plug 'romainl/Apprentice'
Plug 'severin-lemaignan/vim-minimap'
Plug 'morhetz/gruvbox'
Plug 'w0rp/ale'
Plug 'chriskempson/base16-vim'
Plug 'Reewr/vim-monokai-phoenix'
Plug 'micha/vim-colors-solarized'
Plug 'dag/vim-fish'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'
Plug 'maksimr/vim-jsbeautify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'christoomey/vim-titlecase'
Plug 'christoomey/vim-tmux-navigator'
Plug 'christoomey/vim-tmux-runner'
Plug 'editorconfig/editorconfig-vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'junegunn/fzf.vim'
Plug 'khzaw/vim-conceal'
Plug 'mtth/scratch.vim'
Plug 'jacoborus/tender.vim'
Plug 'sjl/badwolf'
Plug 'Lokaltog/vim-distinguished'
Plug 'tkhren/vim-fake'
Plug 'fenetikm/falcon'
Plug 'sheerun/vim-polyglot'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 
Plug 'tweekmonster/django-plus.vim'
Plug 'cosminadrianpopescu/vim-tail'
Plug 'mtdl9/vim-log-highlighting'

call plug#end()

filetype plugin indent on

" }}}

" Keymap {{{

" Disable Ex Mode
map Q <Nop>

" Clear search highlights
nnoremap <silent> <Esc> :nohl<cr>

" Toggle fold at current line
nnoremap <Tab> za

" Navigate without a prefix
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Go up and down visual lines (not logical lines, wrap text)
nnoremap j gj
nnoremap k gk

" Yank to end of line
noremap Y y$

nnoremap ! :!

" Save and Quit
map <M-w> :w<CR>
map <M-q> :qa<CR>
nnoremap <Leader>q :quit<CR>
nnoremap <Leader>w :write<CR>
nnoremap <Leader>x :xit<CR>

" Move lines around
nnoremap <Leader>k :m-2<CR>==
nnoremap <Leader>j :m+<CR>==
nnoremap <M-k>     :m-2<CR>==
nnoremap <M-j>     :m+<CR>==
xnoremap <Leader>k :m-2<CR>gv=gv
xnoremap <Leader>j :m'>+<CR>gv=gv
xnoremap <M-k>     :m-2<CR>gv=gv
xnoremap <M-j>     :m'>+<CR>gv=gv

" Keep search matches in the middle of screen
nnoremap n nzzzv
nnoremap N Nzzzv

" Cursor line to the center of screen
nnoremap <C-m> zz

" Command mode mapping
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" }}}

" Appearance {{{

syntax on
set background=dark
set cursorline
set hlsearch
set ruler
colorscheme onedark

" Fixed styles
hi Comment cterm=italic
hi Function cterm=italic
hi Identifier cterm=italic
hi Normal ctermfg=249 ctermbg=233
hi NonText ctermfg=236 ctermbg=233
hi CursorLine ctermbg=234
hi ColorColumn ctermbg=234
hi Folded cterm=italic ctermfg=238
hi String cterm=italic
hi Search ctermfg=0 ctermbg=120
hi IncSearch ctermfg=120

" }}}

" Plugin: Airline {{{

let g:airline_detect_modified = 1
let g:airline_inactive_collapse = 1
let g:airline_powerline_fonts = 1
let g:airline_symbols_ascii = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'
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
let g:airline_section_c = '%<%{bufferline#refresh_status()}%#airline_c#%#bufferline_selected# %{g:bufferline_status_info.current} %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline_section_z = '%2l%#__restore__#%#__accent_bold#/%L%{g:airline_symbols.maxlinenr}%#__restore__# :%2v'

" }}}

" Plugin: NERDTree {{{
"
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
" let g:rbpt_colorpairs = [
"         \ ['blue',       '#FF6000'],
"         \ ['cyan', '#00FFFF'],
"         \ ['darkmagenta',    '#CC00FF'],
"         \ ['yellow',   '#FFFF00'],
"         \ ['red',     '#FF0000'],
"         \ ['darkgreen',    '#00FF00'],
"         \ ['White',         '#c0c0c0'],
"         \ ['blue',       '#FF6000'],
"         \ ['cyan', '#00FFFF'],
"         \ ['darkmagenta',    '#CC00FF'],
"         \ ['yellow',   '#FFFF00'],
"         \ ['red',     '#FF0000'],
"         \ ['darkgreen',    '#00FF00'],
"         \ ['White',         '#c0c0c0'],
"         \ ['blue',       '#FF6000'],
"         \ ['cyan', '#00FFFF'],
"         \ ['darkmagenta',    '#CC00FF'],
"         \ ['yellow',   '#FFFF00'],
"         \ ['red',     '#FF0000'],
"         \ ['darkgreen',    '#00FF00'],
"         \ ['White',         '#c0c0c0'],
"         \ ]

" let g:rbpt_max = 16
" let g:rbpt_loadcmd_toggle = 0
" au VimEnter * RainbowParenthesesToggle
" au Syntax * RainbowParenthesesLoadRound
" au Syntax * RainbowParenthesesLoadSquare
" au Syntax * RainbowParenthesesLoadBraces
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
nnoremap <silent> <Leader>r :VtrOpenRunner<CR>:VtrSendCommandToRunner<CR>
" }}}

" Plugin: VTN - Vim Tmux Navigator {{{
nnoremap <silent> <M-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <M-j> :TmuxNavigateDown<cr>
nnoremap <silent> <M-k> :TmuxNavigateUp<cr>
nnoremap <silent> <M-l> :TmuxNavigateRight<cr>
nnoremap <silent> <M-/> :TmuxNavigatePrevious<cr>
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

" Plugin: UltiSnips {{{

let g:python_host_prog=$HOME.'\AppData\Local\Programs\Python\Python37\python.exe'
let g:python3_host_prog=$HOME.'\AppData\Local\Programs\Python\Python37\python.exe'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=[$HOME.'\AppData\Local\nvim']
let g:UltiSnipsSnippetsDir=$HOME.'\AppData\Local\nvim'

nnoremap <silent> <Leader>es :UltiSnipsEdit<CR>

" }}}

" Plugin: delimitMate {{{ 

let delimitMate_matchpairs = "(:),[:],{:}"

" }}}

" {{{ Plugin: Ale

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['pylint', 'flake8']
\}

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
nnoremap <Leader>nr :call ToggleRelativeNumbers()<CR>

function! Tailf()
    e
    normal G
    redraw

    sleep 1
    call Tailf()
endfunction

" }}}

" Folding {{{
function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let line = substitute(line, '{', '', 'g')

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . ' { ' . foldedlinecount . ' lines ... }' . repeat(' ', fillcharcount)
endfunction " }}}
set foldtext=MyFoldText()
" }}}

" List Syntax Group {{{
nmap <silent> <leader>sp :call <SID>SynStack()<CR>
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" }}}

