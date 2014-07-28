set nocompatible              " be iMproved, required
filetype off                  " required

if filereadable(expand("~/.vim/.vimrc.plugins"))
	source ~/.vim/.vimrc.plugins
endif

set nowrap "don't wrap lines
set background=dark "colorscheme
colorscheme solarized
set number "Turn on line numbers
set numberwidth=4
set backspace=indent,eol,start  "Allow backspace in insert mode
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set hidden                      "Allow current buffer to be put in background
                                "without being written to disk
set autoread                    "reload files changed outside of vim
set encoding=utf8 "utf8 incoding
set smartindent "smart indentation overriden by individual filetype settings
set showmatch "show matching braces, brackets and such
" command timeout settings
set ttimeout
set ttimeoutlen=50
set vb t_vb= "Turn off beeping and visual bells
set incsearch "incremental search
set ls=2 "show status line even when only one window is shown.
set ruler "show the current position (line+col) and percentage in buffer
set ignorecase "don't distinguish between caps in search

set title "set window title

set ttyfast "fast terminal connection
set list "turn on list characters
set history=1000 "keep an extra long history

"set up tabs and indentation, default to 4 space tabs. We don't actually use
"tabs here. This is overwritten in individual syntax files
set shiftwidth=4
set tabstop=4
syntax on "syntax highlighting

"store temp files in non-annoying place
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backup                        " enable backups

"filebased undo across sesions
silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undofile

set colorcolumn=80 "to help us keep our lines under 80 chars (79)
set cursorline

setlocal hlsearch "When there is a previous search pattern, highlight all its matches
setlocal incsearch "While typing a search command, show where the pattern matches

au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
au FileType html setlocal ts=2 sts=2 sw=2 noexpandtab
au FileType css setlocal ts=2 sts=2 sw=2 noexpandtab
au BufWritePre * :%s/\s\+$//e

set listchars=tab:▸\ ,eol:¬

"CtrlP Settings
" Set the max files
let g:ctrlp_max_files = 10000
" Find nearest ancestor that contains source control files.
let g:ctrlp_working_path_mode = 2
let g:ctrlp_root_markers = ['.git/']
" Optimize file searching
if has("unix")
    let g:ctrlp_user_command = {
                \   'types': {
                \       1: ['.git/', 'cd %s && git ls-files']
                \   },
                \   'fallback': 'find %s -type f | head -' . g:ctrlp_max_files
                \ }
endif

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,.hg/,.svn/
let NERDTreeIgnore = ['\.pyc$', '\.swp$', '\.git$', '\.ropeproject/$']

" Fix Cursor in TMUX
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Enable basic mouse behavior such as resizing buffers.
set mouse=a
if exists('$TMUX')  " Support resizing in tmux
    set ttymouse=xterm2
endif

set shell=bash

"mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>
let mapleader = ","
"control up down to change between buffers
noremap <C-Down> <C-W>j
noremap <C-Up> <C-W>k
"changes the buffer in the current window to the next or the previous one
noremap <C-right> <ESC>:bn<CR>
noremap <C-left> <ESC>:bp<CR>
"oops? forgot to sudo? w!!
cmap w!! w !sudo tee %
"<Esc> to jj
imap jj <Esc>
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
nmap <leader>l :set list!<CR>
nmap <leader>a <Esc>:Ag<space>
nmap <leader>cb :CtrlPBuffer<CR>
nmap <leader>nd :NERDTreeToggle<CR>
nmap <leader>gg :GitGutterToggle<CR>
nmap <leader>j :RopeGotoDefinition<CR>
nmap <leader>r :RopeRename<CR>
