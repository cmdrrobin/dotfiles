colorscheme nord

if (has("termguicolors"))
  set termguicolors
endif

set nocompatible          " use Vim settings, rather than Vi
set encoding=utf-8        " Set default encoding

filetype on                    " Enable filetype plugins
filetype plugin indent on      " load plugins and indent files

syntax on                      " Syntax highlighting

set modeline                   " Enable modeline, to read vim settings
set modelines=5                " Within 5 lines (top or bottom)
set title                      " Show info in the window title

set incsearch                  " find the next match as we type the search
set hlsearch                   " highlight searches by default

set ignorecase                 " set search to be case insensitive
set smartcase                  " unless you typed uppercase letters in your query

set number                     " add line numbers
set cursorline                 " highlight line

"indent settings
set shiftwidth=2               " Change the number of space characters inserted for indentation
set tabstop=2                  " Insert 2 spaces for a tab
set softtabstop=2              " Number of spaces for a tab
set expandtab                  " Converts tabs to spaces
set autoindent                 " Good auto indent
set showtabline=2              " Always show tabs
set smarttab                   " Makes tabbing smarter
set smartindent                " Makes indeting smarter

set splitbelow                 " Horizontal splits will automatically be below
set splitright                 " Vertical splits will automatically be to the right


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Do not create swap or backup files when editing passwordstore files
au BufNewFile,BufRead /dev/shm/gopass.* setlocal noswapfile nobackup noundofile

" Higlight specified keys in comments
augroup highlightKeys
  autocmd!
  autocmd Syntax * syntax match highlightKeys /\v\_.<(BUG|FIXME|HACK|NOTE|TODO|XXX).*/hs=s+1 containedin=.*Comment
augroup END
