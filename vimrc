call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'hashivim/vim-hashicorp-tools'
Plug 'junegunn/vim-easy-align'
call plug#end()

colorscheme nord

set nocompatible          "use Vim settings, rather than Vi
set encoding=utf-8        "Set default encoding

filetype plugin indent on      "load plugins and indent files

syntax on                      "Syntax highlighting

set showcmd                    "show incomplete cmds down the bottom
set showmode                   "show current mode down the bottom
set laststatus=2
set modeline
set ruler
set title

set incsearch                  "find the next match as we type the search
set hlsearch                   "highlight searches by default

set ignorecase                 "set search to be case insensitive
set smartcase                  "unless you typed uppercase letters in your query

set number                     "add line numbers
set showbreak=...
set wrap linebreak nolist
set cursorline                 "highlight line
set backspace=indent,eol,start
set whichwrap=h,l,b,<,>,~,[,]

"indent settings
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab                  "use spaces
set shiftround
set autoindent

set iskeyword-=_                  "Underscores denote words

if exists("+colorcolumn")
    set colorcolumn=81            "highlight columns 81 onwards
endif

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 "enable the tabline
let g:airline#extensions#tabline#fnamemod = ':t' " show just the filename of buffers in the tab line
let g:airline_detect_modified=1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Set up CTRL P {{{
" " First set up patterns to ignore
set wildignore+=*/tmp/*,*.so,*/node_modules,*/.git/*,.DS_Store,*.swp,*.zip,*.jpg,*.png,*.gif "patterns to ignore
let g:ctrlp_map = '<c-p>'                           "Open with CTRL+P
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_working_path_mode = ''
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$' "default ignores
let g:ctrlp_by_filename = '1'                       "only look for filenames

:nmap \l :setlocal number!<CR>
:nmap \o :set paste!<CR>

map <C-n> :NERDTreeToggle<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

