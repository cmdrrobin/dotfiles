colorscheme nord

set nocompatible          "use Vim settings, rather than Vi
set encoding=utf-8        "Set default encoding

filetype plugin indent on      "load plugins and indent files

syntax on                      "Syntax highlighting

set showcmd                    "show incomplete cmds down the bottom
set showmode                   "show current mode down the bottom
set laststatus=2
set modeline
set modelines=5
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
set shiftwidth=2               " Change the number of space characters inserted for indentation
set softtabstop=2
set tabstop=2                  " Insert 2 spaces for a tab
set expandtab                  " Converts tabs to spaces
set smarttab                   " Makes tabbing smarter will realize you have 2 vs 4
set autoindent                 " Good auto indent
set showtabline=2              " Always show tabs
" set shiftround

set iskeyword-=_                  "Underscores denote words

if exists("+colorcolumn")
    set colorcolumn=81            "highlight columns 81 onwards
endif

set splitbelow                 " Horizontal splits will automatically be below
set splitright                 " Vertical splits will automatically be to the right


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Do not create swap or backup files when editing passwordstore files
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile
