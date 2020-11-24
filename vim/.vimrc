" .vimrc by Witcher01
" Twitter: https://twitter.com/Witcher_01
"
call plug#begin('~/.vim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
call plug#end()
runtime ftplugin/man.vim

" set colorscheme
colorscheme solarized
"colorscheme wal
set background=dark

" include all subfolders in path
set path+=**

" enable syntax higlighting
syntax enable

" load filetype-specific indent files
filetype plugin indent on

set encoding=utf-8
"set clipboard=unnamedplus

let mapleader = ","

" enable the autocomplete wildmenu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.class

" show linenumbers
set number
" show relative linenumbers
set relativenumber
" keep n amount of lines above/below the cursor when scrolling
set scrolloff=7
" highlight the current line
"set cursorline

" hightlight matching brace
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2
" highlight all search results
set hlsearch
" enable smart-case search
set smartcase
" always case sensitive
set ignorecase
" searches for strings incrementally
set incsearch

" show row and column ruler information
set ruler
" number of undo levels
set undolevels=1000

" number of visual spaces per TAB
set tabstop=4
" number of spaces in tab when editing
set softtabstop=4
" when pressing tab insert spaces
"set expandtab
" when using </>
set shiftwidth=4

" show command in bottom bar
set showcmd
" redraw only when we need to
set lazyredraw
" search as characters are entered
set incsearch

set splitbelow
set splitright

" show shady characters
set listchars=tab:>~,trail:.
set list

" enable folding
set foldenable
" open most folds by default
set foldlevelstart=10
" 10 nested fold max
set foldnestmax=10
" fold based on indent level (marker. manual. expr, syntax, diff, indent)
set foldmethod=syntax
set foldlevel=99

"netrw settings
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25
"live-latex-preview
let tex_preview_always_autosave = 1
"latex indentation
let g:tex_flavor='latex'
" set vimwiki path, syntax, and extension
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'path_html': '~/Documents/vimwiki_html', 'syntax': 'markdown', 'ext': '.md'}]

" enable autocompletion
set wildmode=longest,list,full
set wildmenu
set omnifunc=syntaxcomplete#Complete
set completeopt=longest,menuone,noselect

nnoremap <leader>ev :vs $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" when editing header file, press to open corresponding source file
" in the same directory
nnoremap <leader>oc :e %<.c<cr>
" same as above, but the other way around
nnoremap <leader>oh :e %<.h<cr>

" open a file using fzf in any mode
nnoremap <leader>ef :FZF<cr>
" convert current file to html to opoen in a browser
nnoremap <leader>ch :!pandoc "%" --to=html5 > /tmp/"%:t:r".html

"""BASIC TOOLS
"""NEW COMMANDS
" SuperRetab command, that converts each number of spaces given
" as an argument to one tab
command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g
"""END

"""C
" hightlight the first character in a line longer than 80 chars
autocmd FileType c,h highlight ColorColumn ctermbg=magenta
autocmd FileType c,h call matchadd('ColorColumn', '\%81v', 100)
"""END

"""JAVA
" hightlight the first character in a line longer than 120 chars
autocmd FileType java highlight ColorColumn ctermbg=magenta
autocmd FileType java call matchadd('ColorColumn', '\%121v', 100)
"""END
