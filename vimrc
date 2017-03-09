set nocompatible              " be improved
set t_Co=256                  " 256 color display
set t_ut=                     " no terminal color bleeding in tmux
set history=1000
set autoread                  " auto reload when modified by other apps
set showmode
set showcmd
set wildmenu
set shortmess=I
set wildmode=list:longest
set visualbell
set cursorline
set lazyredraw
set backspace=indent,eol,start
set nofoldenable


" tab key related
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
filetype plugin indent on

" encoding related
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,latin1
set scrolloff=3
set fenc=utf-8
set hidden
set background=dark
syntax on

" undos
set undodir=~/.vim/undodir    " put .un~ files together
set undofile                  " infinite undo

" color and outfit
set number                    " show line number
"set rnu                       " relative number
set wrap                      " auto reline
set foldmethod=indent
set foldnestmax=99
set textwidth=80
set formatoptions=qrn1
set colorcolumn=120           " 81th column colored
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<

set mouse=a

set splitright
set splitbelow

" for molokai, no need for that! 
" line ending color
"au ColorScheme * highlight SpecialKey ctermfg=243
" tab color
"au ColorScheme * highlight NonText ctermfg=243
" line number
"au ColorScheme * highlight lineNr ctermfg=243


autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" filetype fixes
au BufRead,BufNewFile *.md set filetype=markdown
au FileType yaml setlocal shiftwidth=2 tabstop=2 

au FocusLost * :wa

" Search related
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Plugins
"
let g:vimim_cloud=-1
let g:vimim_toggle='pinyin'
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
let g:airline_theme='solarized'
set noshowmode
set laststatus=2

let g:session_autosave='yes'
let g:session_autoload='no'


let NERDTreeIgnore=['\.pyc$', '\.lo$', '\.o', '\.la']
"let NERDTreeWinPos='right'
let g:nerdtree_tabs_open_on_console_startup = 0
let g:startify_disable_at_vimenter = 1

let g:miniBufExplVSplit = 20
let g:miniBufExplBRSplit = 1
let g:miniBufExplAutoStart = 0
let g:miniBufExplCycleArround = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:flake8_show_in_gutter = 1

let g:ag_lhandler="botleft lopen"

runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
Plug 'nathanaelkane/vim-indent-guides'
Plug 'alvan/vim-php-manual'
Plug 'ConradIrwin/vim-bracketed-paste'
"Plug 'christoomey/vim-tmux-navigator'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
"Plug 'whatyouhide/vim-gotham' " Code never sleeps in gotham city
Plug 'altercation/vim-colors-solarized'
"Plug 'tomasr/molokai'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-surround' " causing clipboard issue
"Plug 'vimwiki/vimwiki'
Plug 'vim-scripts/vimim'
"Plug 'oplatek/Conque-Shell'
Plug 'JulesWang/css.vim' " only necessary if your Vim version < 7.4
Plug 'cakebaker/scss-syntax.vim'
"Plug 'ryanss/vim-hackernews' " bugs
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
"Plug 'vim-scripts/Conque-GDB' " not compatiable with vim-plug
"Plug 'Rip-Rip/clang_complete'
Plug 'ervandew/supertab'
"Plug 'klen/python-mode'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
"Plug 'junegunn/vim-easy-align' " I literally don't know how to use
Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'mattn/emmet-vim'
"Plug 'fholgado/minibufexpl.vim'
Plug 'rking/ag.vim'
"Plug 'scrooloose/syntastic'  " syntastic checking 
Plug 'guns/xterm-color-table.vim'
Plug 'craigemery/vim-autotag'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kshenoy/vim-signature'
Plug 'nvie/vim-flake8'
Plug 'Yggdroot/indentLine'
Plug 'pelodelfuego/vim-swoop'
if has('python')
    Plug 'SirVer/ultisnips'
    Plug 'davidhalter/jedi-vim'
    Plug 'honza/vim-snippets'
endif


call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><tab>"
let g:jedi#use_tabs_not_buffers=1
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']

autocmd FileType python setlocal completeopt-=preview " disable doc window in jedi-vim

" mappings
cmap w!! w !sudo tee %
cmap x!! w !sudo tee %<CR><CR>:q!<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<CR>
noremap <leader><leader> :tabnext<CR>
noremap <leader>\| :tabprevious<CR>
noremap <leader>] :tabnext<CR>
noremap <leader>[ :tabprevious<CR>
noremap <leader>+ :tabedit<CR>:Startify<CR>
noremap <leader>h :Startify<CR>

noremap <leader>v :source ~/.vimrc<CR>
noremap <leader>V :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
noremap <leader><Space> :noh<CR>
noremap <leader>q :wq<CR>
noremap <leader>a :Ag<Space>
noremap <leader>m :MBEToggle<cr>
noremap <leader>s :set spell!<CR>

" like tmux
noremap <C-w>m <C-w>\|
noremap <C-w>M <C-w>_
noremap <C-w>\| <C-w>v
noremap <C-w>- <C-w>s

noremap <leader>r :%s/
noremap <leader>R :'<,'>s/
noremap <F3> :%s/
noremap g<F3> :s/

nnoremap / /\v
vnoremap / /\v


noremap <F1> <esc>

noremap <leader>a :Ag! -Q <C-r>=expand('<cword>')<CR><CR>

noremap <F2> :NERDTreeToggle<CR>
noremap <leader>u :UltiSnipsEdit<CR>

noremap <C-j> 5j
noremap <C-h> 5h
noremap <C-k> 5k
noremap <C-l> 5l

noremap <C-n><C-p> :MBEbp<CR>
noremap <C-n><C-n> :MBEbn<CR>
noremap <C-n><C-q> :MBEbd<CR>
noremap <C-n><C-c> :enew<CR>
noremap <C-n><C-b> :MBEToggle<cr>

noremap <C-n>p :MBEbp<CR>
noremap <C-n>n :MBEbn<CR>
noremap <C-n>q :MBEbd<CR>
noremap <C-n>c :enew<CR>
noremap <C-n>b :MBEToggle<cr>

" I type these wrong 50 times per day
nnoremap <C-a> ^
nnoremap <C-e> $
inoremap <C-a> <HOME>
inoremap <C-e> <END>
vnoremap <C-a> ^
vnoremap <C-e> $

noremap <leader>i :IndentLinesToggle<cr>
noremap <leader>t :term<cr>

noremap <leader>j :%!python -m json.tool<cr>

" close nerdtree on open file
let NERDTreeQuitOnOpen=1
" close nerdtree on quit vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif



"colo gotham256 " colorscheme depends on plugins
set background=dark
colo solarized
hi Folded ctermbg=NONE guibg=NONE " I just don't like the folded line to be hied

au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>

set mouse=a

aug QFClose
  au!
  au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif

if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    function! Python_run()
        execute('split')
        execute('term python3 -i '.expand('%'))
    endfunction
    nnoremap <F4> :call Python_run()<CR>
endif
