:syntax on
:colorscheme desert
:set background=dark
:set hlsearch    " highlight search
:set ignorecase  " Do case in sensitive matching with
:set smartcase   " be sensitive when there's a capital letter
:set nowrap
:set textwidth=0                   " Don't wrap lines by default
:set wildmode=longest,list         " At command line, complete longest common string, then list alternatives.
:set backspace=indent,eol,start    " more powerful backspacing
:set tabstop=2                     " Set the default tabstop
:set expandtab                     " Make tabs into spaces (set by tabstop)
:set smarttab                      " Smarter tab levels
:set autoindent
:set cindent
:set cinoptions=:s,ps,ts,cs
:set cinwords=if,else,while,do,for,switch,case
:set number         " show line number
:set ruler          " show position
:set novisualbell   " No blinking
:set noerrorbells   " No noise
:set foldenable     " Turn on folding
:set mouse=a
:set wildmode=longest,list
:set wildmenu

" vim-airline settings
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#fugitive#enabled = 1
let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_detect_paste = 1
