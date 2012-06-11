call pathogen#infect()

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif

" Remap leader
let mapleader = ","

" Use Vim settings
set nocompatible
" show the cursor position all the time
set ruler
set showcmd
" Don't keep a backup or swap file
set nobackup
set noswapfile
set nowritebackup
" keep 1000 lines of command line history
set history=1000
" keep 1000 undo levels
set undolevels=1000
" set encoding
set encoding=utf-8
" We have a modern terminal
set ttyfast
" manages buffers effectively
set hidden
" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Automatically read files
set autoread

" Automatically write buffers that have been unfocused
set autowrite

" Make the mouse work. Scroll, tabs, NERDTree, etc.
set mouse=a

" Bind 'ii' to exit insert mode
imap ii <Esc>

"""
""" Search
"""
" highlight search results by default
set hlsearch
" this can be annoying
nmap <silent> <leader>h :silent :nohlsearch<CR>

" case inferred by default
set infercase
" make searches case-insensitive
set ignorecase
"unless they contain upper-case letters:
set smartcase
" do incremental searching
set incsearch

set laststatus=2  " Always display the status line
" Broken down into easily includeable segments
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=%{fugitive#statusline()} "  Git Hotness
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info


"""
""" Spacing and Layout
"""
" don't make it look like there are line breaks where there aren't:
set nowrap
" Wrap at word
set linebreak

" Softtabs, 4 spaces
set expandtab
set autoindent
set copyindent
set shiftwidth=4
set softtabstop=4

" When shifting from less than 4 spaces, goto 4 instead of 5
set shiftround

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Better unix / windows compatibility
set viewoptions=folds,options,cursor,unix,slash

"""
""" Colors and aesthetics
"""

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" file-type highlighting and configuration
filetype on
filetype plugin on
filetype indent on

set t_Co=256

" Color scheme
colorscheme xoria256
highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Always show line numbers
set number
set numberwidth=5


"""
""" Misc
"""

" Snippets are activated by Shift+Tab
let g:snippetsEmu_key = "<S-Tab>"

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"

" Add clipboard support for MAC OS
set clipboard=unnamed

" Make sure I don't use arrows!!!!!
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" Copy from current to end of line
nnoremap Y y$

" shorten the stupid 'Press ENTER or type command to continue' prompts
set shortmess=atI

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif


augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Set indentation size on *.coffee files to 2
au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

" Set indentation size on *.rb files to 2
au BufNewFile,BufReadPost *.rb setl shiftwidth=2 expandtab

" Set indentation size on *.html files to 2
au BufNewFile,BufReadPost *.html setl shiftwidth=2 softtabstop=2 expandtab

" Set indentation size on *.js files to 2
au BufNewFile,BufReadPost *.js setl shiftwidth=2 softtabstop=2 expandtab

" Auto compile coffeescripts and show errors (redraw for term based vim)
au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

" Mark scss as sass
au BufRead,BufNewFile *.scss set filetype=scss

" Set .as files to be ActionScript
au BufRead,BufNewFile *.as set filetype=actionscript

" Highlight cursorline ONLY in the active window:
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline

" Replace all tabs with spaces
nmap <Leader>dt :%s/\t/    /g<CR>

" Delete all leading whitespace
nmap <Leader>dsl :%s/^\s\s*$//g<CR>

"""
""" NERDTree!
"""

" Close vim if NERDtree is the last buffer open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Bind NERDTreeTabsToggle to <Leader>n
map <Leader>n <plug>NERDTreeTabsToggle<CR>

" Bind NERDTreeFind to <Leader>f
nmap <Leader>f :NERDTreeFind<CR>

"""
""" Tabularize
"""

if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif


" GUI Settings {
" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T " remove the toolbar
    set lines=40      " 40 lines of text instead of 24,
else
endif
" }
