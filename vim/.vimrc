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
"Navigating with guides
inoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
vnoremap <Space><Tab> <Esc>/<++><Enter>"_c4l
map <leader><Tab> <Esc>/<++><Enter>"_c4l
inoremap <leader>gui <++>
"""END

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

"""LATEX
autocmd FileType tex inoremap <leader>em \emph{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>bf \textbf{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>it \textit{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>un \underline{}<Space><++><Esc>T{i
autocmd FileType tex inoremap <leader>en \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap <leader>ct \textcite{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>item \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap <leader>label \label{}<Space><++><Esc>T{i
autocmd FileType tex inoremap <leader>ref \ref{}<Space><++><Esc>T{i
autocmd FileType tex inoremap <leader>tabu \begin{tabular}{}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4k$T{<Esc>i
autocmd FileType tex inoremap <leader>a \href{}{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap <leader>up \usepackage{}<Enter><++><Esc>kT{i
autocmd FileType tex inoremap <leader>rarr \xrightarrow[]{<++>]<Space><++><Esc>T[i
autocmd FileType tex inoremap <leader>txt \text{}<++><Esc>T{i
"Math
autocmd FileType tex inoremap <leader>menv $$<Space><++><Esc>2T$i
autocmd FileType tex inoremap <leader>eq \begin{equation*}<Enter><Enter>\end{equation*}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap <leader>sin \sin()<++><Esc>T(i
autocmd FileType tex inoremap <leader>cos \cos()<++><Esc>T(i
autocmd FileType tex inoremap <leader>tan \tan()<++><Esc>T(i
autocmd FileType tex inoremap <leader>frac \frac{}{<++>}<++><Esc>2T{i
"fractions in text, has to be definded in tex file
autocmd FileType tex inoremap <leader>rfrac \rfrac{}{<++>}<++><Esc>2T{i
autocmd FileType tex inoremap <leader>binom \binom{}{<++>}<++><Esc>2T{i
autocmd FileType tex inoremap <leader>sqrt \sqrt{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>nsqrt \sqrt[]{<++>}<++><Esc>T[i
autocmd FileType tex inoremap <leader>sum \sum_{}^{<++>}<++><Esc>2T{i
autocmd FileType tex inoremap <leader>prod \prod_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>bigcup \bigcup_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>bigcap \bigcap_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>bigvee \bigvee_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>bigwedge \bigwedge_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>int \int_{}^{<++>}<Space><++><Esc>2T{i
autocmd FileType tex inoremap <leader>matr \begin{matrix}<Enter><Enter>\end{matrix}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap <leader>pmatr \begin{pmatrix}<Enter><Enter>\end{pmatrix}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap <leader>hat \hat{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>bar \bar{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>not \not{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>over \overline{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>tilde \not{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>eqdf $<Space>f(n)<Space>=<Enter>\begin{cases}<Enter><++><Space>&<Space>\quad<Enter>\text{<++>}\\<Enter><++><Space>&<Space>\quad<Enter>\text{<++>}<Enter>\end{cases}$
autocmd FileType tex inoremap <leader>mbb \mathbb{}<++><Esc>T{i
autocmd FileType tex inoremap <leader>lim \lim\limits_{}<Space><++><Esc>T{i
autocmd FileType tex inoremap <leader>ali \begin{align*}<Enter><Enter>\end{align*}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap <leader>split \begin{split}<Enter><Enter>\end{split}<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap <leader>mbb \mathbb{}<++><Esc>T{i

"GERMAN SYMBOLS
autocmd FileType tex inoremap <leader>ö {\"o}
autocmd FileType tex inoremap <leader>ä {\"a}
autocmd FileType tex inoremap <leader>ü {\"u}
autocmd FileType tex inoremap <leader>ß {\ss}
autocmd FileType tex inoremap <leader>Ö {\"O}
autocmd FileType tex inoremap <leader>Ä {\"A}
autocmd FileType tex inoremap <leader>ü {\"U}
"""END

