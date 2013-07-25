call pathogen#infect('~/.vim/bundle')
filetype plugin indent on

if &shell !~ '/sh$'
    set shell=/bin/sh
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
" report: show a report when N lines were changed. 0 means 'all'
set report=0

" Automatically read files
set autoread

" Automatically write buffers that have been unfocused
set autowrite

" Make the mouse work. Scroll, tabs, NERDTree, etc.
set mouse=a

" Bind 'jk' to exit insert mode
imap jk <Esc>l

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

" turn on wild command line completion (for :e)
set wildmenu
" Bash tab style completion is awesome
set wildmode=longest,list
" Tab completion key: default value is <C-E> but who doesn't complete with tab?
set wildchar=<tab>
" Ignore these filenames during enhanced command line completion.
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc                            " Python byte code
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Source control
set wildignore+=*/eggs/*,*/develop-eggs/*        " Python buildout


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

" More natural splitting
set splitbelow
set splitright

"""
""" Colors and aesthetics
"""

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Color scheme
set background=dark
colorscheme tomorrow-night
"highlight NonText guibg=#060606
highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Always show line numbers
set number
set numberwidth=5

" Highlight cursorline:
set cursorline

"Highlight cursorline ONLY in the active window:
au WinEnter * setlocal cursorline
au WinLeave * setlocal nocursorline


"""
""" Syntax and language specifics
"""

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

" CSS and LessCSS
augroup ft_css
    au!

    au BufNewFile,BufRead *.less setlocal filetype=less
    au BufNewFile,BufRead *.scss set filetype=scss

    "au Filetype less,css setlocal foldmethod=marker
    "au Filetype less,css setlocal foldmarker={,}
    au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
    au Filetype less,css setlocal iskeyword+=-

    " Use <leader>S to sort properties.  Turns this:
    "
    "     p {
    "         width: 200px;
    "         height: 100px;
    "         background: red;
    "
    "         ...
    "     }
    "
    " into this:

    "     p {
    "         background: red;
    "         height: 100px;
    "         width: 200px;
    "
    "         ...
    "     }
    au BufNewFile,BufRead *.scss,*.css nnoremap <buffer> <localleader>S ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>

    " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
    " positioned inside of them AND the following code doesn't get unfolded.
    au BufNewFile,BufRead *.scss,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END

" Django
augroup ft_django
    au!

    au BufNewFile,BufRead urls.py           setlocal nowrap
    au BufNewFile,BufRead urls.py           normal! zR
    au BufNewFile,BufRead dashboard.py      normal! zR
    au BufNewFile,BufRead local_settings.py normal! zR

    au BufNewFile,BufRead admin.py            setlocal filetype=python.django
    au BufNewFile,BufRead urls.py             setlocal filetype=python.django
    au BufNewFile,BufRead models.py           setlocal filetype=python.django
    au BufNewFile,BufRead views.py            setlocal filetype=python.django
    au BufNewFile,BufRead settings.py         setlocal filetype=python.django
    au BufNewFile,BufRead forms.py            setlocal filetype=python.django
    au BufNewFile,BufRead common_settings.py  setlocal filetype=python.django
augroup END

" HTML and HTMLDjango
augroup ft_html
    au!

    au BufNewFile,BufRead *.html setlocal filetype=htmldjango
    au BufNewFile,BufReadPost *.html setl shiftwidth=2 softtabstop=2 expandtab

    au FileType html setlocal omnifunc=htmlcomplete#CompleteTags
    " Use Shift-Return to turn this:
    "     <tag>|</tag>
    "
    " into this:
    "     <tag>
    "         |
    "     </tag>
    au FileType html,jinja,htmldjango nnoremap <buffer> <s-cr> vit<esc>a<cr><esc>vito<esc>i<cr><esc>

    " Django tags
    au FileType jinja,htmldjango inoremap <buffer> <c-t> {%<space><space>%}<left><left><left>

    " Django variables
    au FileType jinja,htmldjango inoremap <buffer> <c-f> {{<space><space>}}<left><left><left>
augroup END

" Javascript and CoffeeScript
augroup ft_javascript
    au!

    " Auto compile coffeescripts and show errors (redraw for term based vim)
    au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

    " Set indentation size on *.coffee files to 2
    au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab

    au FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    au FileType javascript setlocal shiftwidth=4 softtabstop=4 expandtab
    "au FileType javascript setlocal foldmethod=marker
    "au FileType javascript setlocal foldmarker={,}
augroup END

" Ruby
augroup ft_ruby
    au!

    au Filetype ruby setlocal shiftwidth=2
    au Filetype ruby setlocal softtabstop=2
augroup END

" ActionScript
augroup ft_actionscript
    au!

    " Set .as files to be ActionScript
    au BufRead,BufNewFile *.as set filetype=actionscript
augroup END


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


" Replace all tabs with spaces (2 spaces)
nmap <Leader>dt2 :%s/\t/  /g<CR>

" Replace all tabs with spaces (4 spaces)
nmap <Leader>dt4 :%s/\t/    /g<CR>

" Delete all leading whitespace
nmap <Leader>dls :%s/^\s\s*$//g<CR>

" NO more shit
nnoremap ; :

nmap <Leader>pdb oimport pdb; pdb.set_trace()<cr>

"""
""" PeepOpen
"""
" nnoremap <c-p> :PeepOpen<cr>

"""
""" Ctrl-P
"""
set wildignore+=*/eggs/*,*.orig,*.zip

"""
""" TagList
"""

nmap <Leader>t :TlistToggle<CR>

"""
""" NERDTree!
"""

" Close vim if NERDtree is the last buffer open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Bind NERDTreeTabsToggle to <Leader>n
map <Leader>n :NERDTreeTabsToggle<CR>

" Bind NERDTreeFind to <Leader>f
nmap <Leader>f :NERDTreeFind<CR>


"""
""" Yelp
"""
function YelpSettings()
    setlocal noexpandtab    " don't turn them into spaces
    setlocal shiftwidth=4   " auto-indent width
    setlocal tabstop=4      " display width of a physical tab character
    setlocal softtabstop=0  " disable part-tab-part-space tabbing
endfunction
autocmd BufNewFile,BufRead ~/pg/* call YelpSettings()

"""
""" GUI Settings
"""
if has('gui_running')
    set guifont=Monaco:h12

    set guioptions+=c " use console dialogs
    set guioptions-=e " don't use gui tabs
    set guioptions-=T " don't show toolbar
    set guioptions-=m " don't show menu bar
    set guioptions-=l " don't show left-hand scrollbar
    set guioptions-=L " don't show left-hand scrollbar
    set guioptions-=r " don't show right-hand scrollbar
    set guioptions-=R " don't show right-hand scrollbar

    " Use a line-drawing char for pretty vertical splits.
    set fillchars+=vert:│

    " start in fullscreen mode
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen

    " quickselect tabs with Apple + # (gvim only)
    nnoremap <D-1> :tabn 1<CR>
    nnoremap <D-2> :tabn 2<CR>
    nnoremap <D-3> :tabn 3<CR>
    nnoremap <D-4> :tabn 4<CR>
    nnoremap <D-5> :tabn 5<CR>
    nnoremap <D-6> :tabn 6<CR>
    nnoremap <D-7> :tabn 7<CR>
    nnoremap <D-8> :tabn 8<CR>
    nnoremap <D-9> :tabn 9<CR>"" GVIM- (here instead of .gvimrc)
else
endif
" }
