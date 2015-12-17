set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'ervandew/supertab'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'mattn/emmet-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
" Plugin 'garbas/vim-snipmate'
" Plugin 'honza/vim-snippets'
Plugin 'raimondi/delimitmate'
Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/syntastic'
Plugin 'ap/vim-css-color'
Plugin 'nanotech/jellybeans.vim'
Plugin 'ciaranm/inkpot'
Plugin 'jonathanfilip/vim-lucius'
Plugin 'chriskempson/vim-tomorrow-theme'
Plugin 'sheerun/vim-wombat-scheme'
Plugin 'tomasr/molokai'
Plugin 'w0ng/vim-hybrid'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'Yggdroot/indentLine'
" Plugin 'bronson/vim-trailing-whitespace'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'bling/vim-bufferline'
" Plugin 'zenorocha/dracula-theme', {'rtp': 'vim/'}
Plugin 'kien/ctrlp.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'cakebaker/scss-syntax.vim'

set runtimepath^=~/.vim/bundle/vim-snipmate

call vundle#end()
filetype plugin indent on
"filetype plugin on

" Brief help
" :PluginList
" :PluginInstall
" :PluginSearch foo
" :PluginClean

set background=dark
colorscheme molokai
syntax on
set mouse=a
set showmatch
" set rtp+=$HOME/.local/lib/python2.7/site-packages/powerline/bindings/vim/
let g:airline_powerline_fonts = 1
set laststatus=2
set t_Co=256
set number
set relativenumber
set nowrap
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems
" Syntax coloring lines that are too long just slows down the world
set synmaxcol=128
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
" autocmd! bufwritepre * set expandtab | retab! 4

" cmap W w
" cmap WQ wq
" cmap wQ wq
" cmap Q q

" Syntastic
" let g:syntastic_check_on_open=1
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_javascript_jshint_exec='/usr/local/bin/jshint'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinPos = 'right'

" Rainbow Parentheses
let g:rbpt_colorpairs = [
        \ ['blue',       '#FF6000'],
        \ ['cyan', '#00FFFF'],
        \ ['darkmagenta',    '#CC00FF'],
        \ ['yellow',   '#FFFF00'],
        \ ['red',     '#FF0000'],
        \ ['darkgreen',    '#00FF00'],
        \ ['White',         '#c0c0c0'],
        \ ['blue',       '#FF6000'],
        \ ['cyan', '#00FFFF'],
        \ ['darkmagenta',    '#CC00FF'],
        \ ['yellow',   '#FFFF00'],
        \ ['red',     '#FF0000'],
        \ ['darkgreen',    '#00FF00'],
        \ ['White',         '#c0c0c0'],
        \ ['blue',       '#FF6000'],
        \ ['cyan', '#00FFFF'],
        \ ['darkmagenta',    '#CC00FF'],
        \ ['yellow',   '#FFFF00'],
        \ ['red',     '#FF0000'],
        \ ['darkgreen',    '#00FF00'],
        \ ['White',         '#c0c0c0'],
        \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Indent Lines
let g:indentLine_color_term = 236
let g:indentLine_char = '¦'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
