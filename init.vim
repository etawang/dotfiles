" vimawesome.com
" Vim Plug

call plug#begin('~/.vim/plugged')

Plug 'fatih/vim-go'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/syntastic'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-endwise'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'mileszs/ack.vim'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'morhetz/gruvbox'

call plug#end()

" Plugin Configurations
let g:ackprg = 'ag --vimgrep'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Use Deoplete.
let g:deoplete#enable_at_startup = 1
let g:elixir_docpreview = 0

" Let <Tab> also do completion
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:fugitive_github_domains = ['git.musta.ch']

nnoremap <leader>go :Gbrowse<cr>
vnoremap <leader>go :Gbrowse<cr>

" Open CtrlP vim with C-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Open nerdtree with C-n
map <C-n> :NERDTreeToggle<CR>

" Macros

" Use % to find the end of a ruby block
runtime! macros/matchit.vim

" General configurations
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set relativenumber     	" Show the relativeline numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set softtabstop=1
set shiftwidth=2        " Indentation amount for < and > commands.
set encoding=utf-8

set noerrorbells        " No beeps.
set modeline            " Enable modeline.
set esckeys             " Cursor keys in insert mode.
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline
set nostartofline       " Do not jump to first character with page commands.

set hlsearch            " Highlight search results.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set incsearch           " Incremental search.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" TrueColor
let g:gruvbox_italic=1
set termguicolors
set background=dark
colorscheme gruvbox

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" if exists('+colorcolumn')
"   set colorcolumn=+1 " vertical line at `textwidth` characters
" endif

"set textwidth=80

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc

set undofile
set undodir=/Users/esther_wang/.vim/.vimundo

set clipboard=unnamed

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

nnoremap ; :
