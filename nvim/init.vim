" vimawesome.com
" Vim Plug

call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/vim-easy-align'

Plug 'tpope/vim-fugitive'

Plug 'scrooloose/syntastic'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-endwise'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'mileszs/ack.vim'

" Plug 'ctrlpvim/ctrlp.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/plugged/fzf', 'do': './install --bin' }

Plug 'junegunn/fzf.vim'
call plug#end()

" Plugin Configurations
let g:ackprg = 'ag --vimgrep'
cnoreabbrev Ack Ack!
nnoremap <leader>a :Ack!<Space>

let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

" Use Deoplete.
let g:deoplete#enable_at_startup = 1
let g:elixir_docpreview = 0

" Let <Tab> also do completion
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-i>"

" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:fugitive_github_domains = ['github.com', 'git.musta.ch']

nnoremap <leader>go :Gbrowse<cr>
vnoremap <leader>go :Gbrowse<cr>

" Open CtrlP vim with C-p
" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'

"Only refreshes the results every 100ms so if you type fast searches don’t pile up
" let g:ctrlp_lazy_update = 100

"Quicker indexing
" let g:ctrlp_user_command = 'find %s -type f | egrep -iv "(\.(eot|gif|gz|ico|jpg|jpeg|otf|png|psd|pyc|svg|ttf|woff|zip)$)|(/\.)|((^|\/)tmp\/)"'

" Open nerdtree with C-n
map <C-n> :NERDTreeToggle<CR>
"End PluginConfigurations

" Macros
" Use % to find the end of a ruby block
runtime! macros/matchit.vim
" End Macros

" General configurations
highlight ExtraWhitespace ctermbg=167 guibg=#fb4934
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Set whitespace color scheme, and make sure it isn't cleared by setting the
" color scheme in later commands.
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=167 guibg=#fb4934

" Highlight text in column textwidth, and allow search highlighting to override
" this highlighting.
autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%'.&tw.'v.', -1)

set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set relativenumber     	" Show the relativeline numbers on the left side.
set formatoptions+=o    " Continue comment marker in new lines.
set formatoptions+=c    " auto-wrap comments using textwidth
set formatoptions+=n    " smart auto-indenting inside numbered lists
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

set statusline=%f\:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%=[%4l/%L]\ %3c

" Colors
let g:gruvbox_italic=1
set termguicolors
set background=dark
colorscheme gruvbox

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" if exists('+colorcolumn')
  " set colorcolumn=+1 " vertical line at `textwidth` characters
" endif

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
set undodir=/Users/esther_wang/.config/nvim/.vimundo

set clipboard=unnamed

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

nnoremap ; :
" End General Configurations
