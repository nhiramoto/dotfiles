set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
" Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'airblade/vim-gitgutter'
" Plugin 'mattn/emmet-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'raimondi/delimitmate'
" Plugin 'scrooloose/syntastic'
Plugin 'jshint/jshint'
" Plugin 'ap/vim-css-color'
Plugin 'gko/vim-coloresque'
" Plugin 'kien/rainbow_parentheses.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'ciaranm/inkpot'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'sheerun/vim-wombat-scheme'
Plugin 'tomasr/molokai'
Plugin 'w0ng/vim-hybrid'
Plugin 'Yggdroot/indentLine'
" Plugin 'bronson/vim-trailing-whitespace'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'bling/vim-bufferline'
" Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'nlknguyen/papercolor-theme'
Plugin 'PotatoesMaster/i3-vim-syntax'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'romainl/Apprentice'
Plugin 'joshdick/onedark.vim'
Plugin 'ying17zi/vim-live-latex-preview'
"Plugin 'ternjs/tern_for_vim'
Plugin 'severin-lemaignan/vim-minimap'

set runtimepath^=~/.vim/bundle/vim-snippets

call vundle#end()
filetype plugin indent on
"filetype plugin on

" Brief help
" :PluginList
" :PluginInstall
" :PluginSearch foo
" :PluginClean

"if $COLORTERM == 'gnome-terminal'
    "set t_Co=256
"endif

"set foldmethod=syntax
"set foldnestmax=1
"let javaScript_fold=1         " JavaScript
"let perl_fold=1               " Perl
"let php_folding=1             " PHP
"let r_syntax_folding=1        " R
"let ruby_fold=1               " Ruby
"let sh_fold_enabled=1         " sh
"let vimsyn_folding='af'       " Vim script
"let xml_syntax_folding=1      " XML

set background=dark
colorscheme onedark
syntax on
set mouse=a
set showmatch
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
let g:airline_powerline_fonts = 1
set laststatus=2
set number
set norelativenumber
set fillchars+=vert:\┃
set nowrap
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=200
hi Normal ctermfg=252 ctermbg=none
set conceallevel=0

map <C-s> :update<CR>

set nobackup
set nowb
set noswapfile

set mouse=c

" use 4 spaces for tabs
set tabstop=4 softtabstop=4 shiftwidth=4

" display indentation guides
" set list listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×

" convert tabs to spaces when reading file
autocmd! bufreadpost * set expandtab | retab! 4

" convert tabs to spaces before writing file
autocmd! bufwritepre * set expandtab | retab! 4

" cmap W w
" cmap WQ wq
" cmap wQ wq
" cmap Q q

" Syntastic
"let g:syntastic_check_on_open=1
"let g:syntastic_javascript_checkers = ['jshint']
"let g:syntastic_javascript_jshint_exec='/usr/sbin/jshint'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_wq = 0

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinPos = 'left'
let NERDTreeShowHidden=1

" NERDCommenter
let g:NERDScapeDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

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

" Indent Lines
let g:indentLine_color_term = 236
let g:indentLine_char = '¦'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_show_hidden = 1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png

" Multiple Cursors
let g:multi_cursor_use_default_mapping=0
" Map start key separately from next key
"let g:multi_cursor_start_key='<F6>'
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-D>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

" Show double quotes in json files
let g:vim_json_syntax_conceal = 0

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
