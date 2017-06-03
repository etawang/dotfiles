" vimawesome.com
" Vim Plug

call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go'

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

Plug 'scrooloose/nerdcommenter'

Plug 'junegunn/vim-easy-align'

" Git and Gbrowse
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

Plug 'scrooloose/syntastic'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-endwise'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'mileszs/ack.vim'

Plug 'christoomey/vim-tmux-navigator'

Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/plugged/fzf', 'do': './install --bin' }

Plug 'junegunn/fzf.vim'

Plug 'lervag/vimtex'

" Visualized marks
Plug 'kshenoy/vim-signature'

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Color scheme
Plug 'chriskempson/base16-vim'

call plug#end()

" Plugin Configurations
let g:ackprg = 'rg --vimgrep'
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

" Open nerdtree with C-n
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeShowLineNumbers = 1

let g:vimtex_latexmk_enabled = 0

let g:airline_powerline_fonts = 1
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

"Visuals
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set relativenumber     	" Show the relativeline numbers on the left side.
set number              " Show current line number even in relative mode.
set ruler               " Show the line and column numbers of the cursor.

" Text
set formatoptions+=o    " Continue comment marker in new lines.
set formatoptions+=c    " Auto-wrap comments using textwidth
set formatoptions+=n    " Smart auto-indenting inside numbered lists
set formatoptions+=1    " Don't break a line after a one-letter word
set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
set textwidth=0         " Hard-wrap long lines as you type them.
set expandtab           " Insert spaces when TAB is pressed.
set tabstop=2           " Render TABs using this many spaces.
set softtabstop=1
set shiftwidth=2        " Indentation amount for < and > commands.
set linebreak
set encoding=utf-8

set noerrorbells        " No beeps.
set modeline            " Enable modeline.

" More natural splits
set splitbelow          " Horizontal split below current.
set splitright          " Vertical split to right of current.

" Movement
set nostartofline       " Do not jump to first character with page commands.
if !&scrolloff
  set scrolloff=3       " Show next 3 lines while scrolling.
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling.
endif
set display+=lastline

" Search
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
" Truecolor
set termguicolors

" If using base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Relative numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc

" Toggle between normal and relative numbering.
nnoremap <leader>r :call NumberToggle()<cr>

" Turn off highlighting after a search.
nnoremap <esc> :noh<cr><esc>

" Resize pane widths
nnoremap <silent> <A-[> <C-w>5<
nnoremap <silent> <A-]> <C-w>5>
nnoremap <silent> <A-{> <C-w><
nnoremap <silent> <A-}> <C-w>>

set undofile
set undodir=~/.config/nvim/.vimundo

set clipboard=unnamed

" Filetype-specific commands
" Syntax highlight in code files
au BufRead,BufNewFile *.cs set syntax=ruby

" Turn on spellcheck
au BufRead,BufNewFile *.(txt|tex) set spell

" Don't auto-indent tex files
au BufRead,BufNewFile *.tex set indentexpr=

" End General Configurations
