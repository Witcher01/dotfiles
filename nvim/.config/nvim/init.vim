" .vimrc by Witcher01
" Twitter: https://twitter.com/Witcher_01
"
call plug#begin('$XDG_CONFIG_HOME/nvim/plugged')
Plug 'vimwiki/vimwiki'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive' " git extension
Plug 'sirver/ultisnips' " snippet manager
Plug 'honza/vim-snippets' " various snippets for ultisnips
"Plug 'artur-shaik/vim-javacomplete2'
Plug 'lervag/vimtex'
Plug 'junegunn/fzf.vim'
call plug#end()
"untime ftplugin/man.vim

" set colorscheme
"colorscheme solarized
colorscheme darkblue
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
let localleader = "\\"

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

"""PLUGINS
"" netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 25

"" vimwiki
" set vimwiki path, syntax, and extension
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/', 'path_html': '~/Documents/vimwiki_html', 'syntax': 'markdown', 'ext': '.md'}]

"" youcompleteme
let g:ycm_key_list_select_completion = ['<C-n>']
let g:ycm_key_list_previous_completion = ['<C-p>']
let g:ycm_key_invoke_completion = '<C-Space>'
let g:ycm_key_list_stop_completion = ['<C-y>']
" stop ycm from letting the autocompletion pop up all the time
let g:ycm_auto_trigger = 0
" only allow ycm to trigger on the specified filetypes
let g:ycm_filetype_whitelist = {'java':1, 'c':1, 'tex':1}
" disable auto hinting on hovering over a field
let g:ycm_auto_hover = ""
" query ultisnips for possible completion of snippet triggers
let g:ycm_use_ultisnips_completer = 1
nmap <leader>D <plug>(YCMHover)

"" vimtex
" enable autocompletion with YCM
if !exists('g:ycm_semantic_triggers')
  let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme
" set vimtex pdf viewer to zathura
let g:vimtex_view_method = 'zathura'
" enable navigation via fzf
nnoremap <localleader>lt :call vimtex#fzf#run()<cr>
" set the compiler method to latexrun
let g:vimtex_compiler_method = 'latexmk'
" set tex flavor to latex
let g:tex_flavor = 'latex'

"" ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"" FZF
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 

imap <c-x><c-f> <plug>(fzf-complete-path)

"""END

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

" replace grep with ripgrep
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

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
"autocmd FileType java setlocal omnifunc=javacomplete#Complete
"""END
