syntax on

filetype indent plugin on  " Wrap gitcommit file types at the appropriate
syntax enable      " syntax highlighting
set number         " line numbering
set vb             " flashes screen on errors
set hlsearch       " highlight search terms
set incsearch
set ignorecase

" indentation
set smartindent
set autoindent     " open lines at same indentation
set expandtab      " turn tabs into tabstop spaces
set tabstop=4      " 1 tab = 4 spaces
set shiftwidth=4   " shift 4 spaces 

set textwidth=76
set wildmenu
set mouse=a        " allow mouse
set cursorline     " highlights/underlines current line
set ruler          " shows cursor position

set background=dark
set t_Co=25" Enable syntax highlighting
syntax on
syntax enable

" File type detection and plugins
filetype plugin indent on

" General UI settings
set number              " Show absolute line number on current line
set relativenumber      " Show relative line numbers for others
set wildmenu            " Enhanced command-line completion
set mouse=a             " Enable mouse support
set background=dark     " Set background to dark
set t_Co=256            " Enable 256 colors

" Search settings
set hlsearch            " Highlight search matches
set incsearch           " Incremental search
set ignorecase          " Case-insensitive search

" Indentation
set autoindent          " Maintain indent of current line
set smartindent         " Smart autoindenting for new lines
set expandtab           " Use spaces instead of tabs
set tabstop=4           " Tab character is 4 spaces wide
set shiftwidth=4        " Indent/outdent by 4 spaces

" Text formatting
set textwidth=76        " Auto-wrap lines at 76 characters

" Error feedback
set noerrorbells        " Disable error beeps
set novisualbell        " Disable screen flashes
set t_vb=               " Reset terminal visual bell behavior

