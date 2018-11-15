
" When use fish-shell
set shell=/bin/bash

set nocompatible
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
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
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
" Installed via pacman
Plugin 'junegunn/fzf.vim'

" Use conceal to replace keywords with unicode symbols
Plugin 'khzaw/vim-conceal'

set runtimepath^=~/.vim/bundle/vim-snippets
set runtimepath^=~/.vim/after/my-snippets

call vundle#end()
filetype plugin indent on

" Brief help
" :PluginList
" :PluginInstall
" :PluginSearch foo
" :PluginClean

"if $COLORTERM == 'gnome-terminal'
    "set t_Co=256
"endif

" Fold
set nofoldenable
set foldmethod=indent
"set foldnestmax=1
"let javaScript_fold=1         " JavaScript
"let perl_fold=1               " Perl
"let php_folding=1             " PHP
"let r_syntax_folding=1        " R
"let ruby_fold=1               " Ruby
"let sh_fold_enabled=1         " sh
"let vimsyn_folding='af'       " Vim script
"let xml_syntax_folding=1      " XML

" Gruvbox theme
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_termcolors=16

" Ayu theme
let ayucolor="mirage"

set background=dark
colorscheme apprentice
syntax on
"hi Normal ctermfg=252 ctermbg=none

" Use system clipboard (tested on Arch Linux)
set clipboard=unnamedplus

set showmatch
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set number
set relativenumber
set fillchars+=vert:\┃
set nowrap
set ttyfast " u got a fast terminal
set lazyredraw " to avoid scrolling problems
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=200

" Backup/tmp files
set nobackup
set nowritebackup
set noswapfile

" Enable mouse for all modes
set mouse=a

" Indentation
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" display indentation guides
set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×

" convert tabs to spaces when reading file
"autocmd! bufreadpost * set expandtab | retab! 4

" convert tabs to spaces before writing file
"autocmd! bufwritepre * set expandtab | retab! 4

" cmap W w
" cmap WQ wq
" cmap wQ wq
" cmap Q q

" Airline
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

" Highlights Styles
hi clear texItalStyle
hi clear texBoldStyle

" Set default TeX flavour
let g:tex_flavor = "latex"

" " Syntastic
" let g:syntastic_check_on_open=1
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_jshint_exec='/usr/sbin/jshint'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_wq = 0

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinPos = 'left'
let NERDTreeShowHidden=1

" " NERDCommenter
" let g:NERDScapeDelims = 1
" let g:NERDCompactSexyComs = 1
" let g:NERDDefaultAlign = 'left'
" let g:NERDCommentEmptyLines = 1
" let g:NERDTrimTrailingWhitespace = 1

" Rainbow Parentheses
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

" " Indent Lines
" let g:indentLine_color_term = 236
" let g:indentLine_char = '¦'
" let g:indentLine_leadingSpaceEnabled = 1
" let g:indentLine_leadingSpaceChar = '·'
" let g:indentLine_setConceal = 2
" let g:indentLine_fileTypeExclude = ['json', 'md']

" " CtrlP
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_show_hidden = 1
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip
" set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

" Multiple Cursors
let g:multi_cursor_use_default_mapping=0
" Map start key separately from next key
"let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_next_key='*'
let g:multi_cursor_prev_key='#'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Commentaries in italic mode
highlight Comment cterm=italic

"enable keyboard shortcuts
"let g:tern_map_keys=1
"show argument hints
"let g:tern_show_argument_hints='on_hold'

" Minimap
"let g:minimap_show='<leader>ms'
"let g:minimap_update='<leader>mu'
"let g:minimap_close='<leader>gc'
"let g:minimap_toggle='<leader>gt'
let g:minimap_highlight='Visual'

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" nvim vs vim configurations
if has('nvim')
    " Neovim specific commands
    set termguicolors
else
    " Standard vim specific commands
endif

map <F6> :setlocal spell! spelllang=en_us<CR>

" js-beautify
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

" VTR - Vim Tmux Runner
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

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

" fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_command_prefix = 'Fzf'
nnoremap <C-p> :FzfFiles<cr>

" " vim-instant-markdown
" let g:instant_markdown_autostart = 1 " Autostart
" let g:instant_markdown_open_to_the_world = 0 " Allow remote connection?
" let g:instant_markdown_allow_unsafe_content = 0 " Allow scripts to run?
" let g:instant_markdown_allow_external_content = 1 " Allow external content such as images, stylesheets and frames

" vim-markdown-preview
" let vim_markdown_preview_hotkey='<C-m>'
" let vim_markdown_preview_browser=''
" let vim_markdown_preview_pandoc=0
" let vim_markdown_preview_use_xdg_open=1

" Open typora for markdown preview
autocmd FileType markdown noremap <silent> <C-m> :exec 'silent !typora % &'<cr>

" Conceal
set conceallevel=1
set concealcursor="nc"
" Show double quotes in json files
let g:vim_json_syntax_conceal = 0

" Automatically reload files changed outside vim
au FocusGained,BufEnter * :checktime
