""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""               
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  

" Disable compatibility with vi which can cause unexpected issues.
 set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
 filetype on

" Enable plugins and load plugin for the detected file type.
 filetype plugin on

" Load an indent file for the detected file type.
 filetype indent on

" Turn syntax highlighting on.
 syntax on

" Add numbers to each line on the left-hand side.
 set number

" Set relative numbers
 set relativenumber

" Use space characters instead of tabs.
 set expandtab

" Do not save backup files.
 set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
 set scrolloff=999

" Do not wrap lines. Allow long lines to extend as far as the line goes.
 set nowrap

" While searching though a file incrementally highlight matching characters as you type.
 set incsearch

" Ignore capital letters during search.
 set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
 set smartcase

" Show partial command you type in the last line of the screen.
 set showcmd

" Show the mode you are on the last line.
 set showmode

" Show matching words during a search.
 set showmatch

" Use highlighting when doing a search.
 set hlsearch

" Set the commands to save in history default number is 20.
 set history=1000

" Enable auto completion menu after pressing TAB.
 set wildmenu

" Make wildmenu behave like similar to Bash completion.
 set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
 set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

 set nocursorline
 set nocursorcolumn

" PLUGINS ---------------------------------------------------------------- {{{

" Plugin code goes here.
call plug#begin()

"  Plug 'dense-analysis/ale'

"  Plug 'preservim/nerdtree'

Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

call plug#end()
" }}}


" MAPPINGS --------------------------------------------------------------- {{{

" Mappings code goes here.
let mapleader = "\<Space>"

""" Insert mode
inoremap jk <esc>

""" Normal mode
" Navigation
nnoremap <Leader>j J
nnoremap H 0
nnoremap J 9j
nnoremap K 9k
nnoremap L $

" Splits
nnoremap <Leader>s :sp<CR>
nnoremap <Leader>v :vsp<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"
" Tabs
nnoremap <Leader>h :tabprevious<CR>
nnoremap <Leader>l :tabnext<CR>
nnoremap <Leader>tt :tabnew<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tc :tabclose<CR>

" Clear highlights
nnoremap <Leader>c :nohl<CR>
" Remap save
nnoremap <Leader>w :w<CR>

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
" nnoremap o o<esc>
" nnoremap O O<esc>

" Yank from cursor to the end of line.
nnoremap Y y$

" NERDTree specific mappings.
" Map the F3 key to toggle NERDTree open and close.
"nnoremap <F3> :NERDTreeToggle<CR>


" Have nerdtree ignore certain files and directories.
"let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" }}}


" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" More Vimscripts code goes here.
" Switch to absolute line numbers in insert mode
augroup smart_relative_line
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter   * if &nu && mode() != "i" | set rnu     | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave     * if &nu                  | set nornu   | endif    
augroup END

" If the current file type is HTML, set indentation to 2 spaces.
autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

" If Vim version is equal to or greater than 7.3 enable undofile.
" This allows you to undo changes to a file even after saving it.
if version >= 703
    set undodir=~/.vim/backup
    set undofile
    set undoreload=10000
endif

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

" If GUI version of Vim is running set these options.
" if has('gui_running')

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme molokai

    " Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
    set guifont="Consolas Code PL" \ Regular\ 12

    " Display more of the file by default.
    " Hide the toolbar.
    set guioptions-=T

    " Hide the the left-side scroll bar.
    set guioptions-=L

    " Hide the the right-side scroll bar.
    set guioptions-=r

    " Hide the the menu bar.
    set guioptions-=m

    " Hide the the bottom scroll bar.
    set guioptions-=b

    " Map the F4 key to toggle the menu, toolbar, and scroll bar.
    " <Bar> is the pipe character.
    " <CR> is the enter key.
   " nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
   "     \set guioptions-=mTr<Bar>
   "     \else<Bar>
   "     \set guioptions+=mTr<Bar>
   "     \endif<CR>

" endif

    " Set autocomplete function to work with LSP
    function! s:on_lsp_buffer_enabled() abort
            setlocal omnifunc=lsp#complete
    endfunction

    " Configure LSP servers
    "
    " TypeScript
    au User lsp_setup call lsp#register_server({
     \ 'name': 'tsserver',
     \ 'cmd': {server_info->['tsserver']},
     \ 'whitelist': ['typescript', 'javascript'],
     \ })

    " call function above when LSP is loaded. 
    augroup lsp_install
      au!
      autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
    augroup END

    " Limit syntax highlighting buffer.
    au BufNewFile,BufRead *.ts setlocal syntax=off

" }}}


" STATUS LINE ------------------------------------------------------------ {{{

" Status bar code goes here.

" Clear status line when vimrc is reloaded.
set statusline=

" Status line left side.
set statusline+=\ %F\ %M\ %Y\ %R

" Use a divider to separate the left side from the right side.
set statusline+=%=

" Status line right side.
" set statusline+=\ ascii:\ %b\ hex:\ 0x%B\ row:\ %l\ col:\ %c\ percent:\ %p%%

" Show the status on the second to last line.
set laststatus=2
" }}}
