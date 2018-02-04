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
set conceallevel=0


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
set nowrap                      " auto reline
set foldmethod=indent
set foldnestmax=99
set textwidth=80
set formatoptions=qrn1
set colorcolumn=80           " 81th column colored
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
au FileType vue setlocal shiftwidth=2 tabstop=2
au FileType javascript setlocal shiftwidth=2 tabstop=2

au FocusLost * :wa

" Search related
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

" Plugins
"

let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
let g:vimim_cloud=-1
let g:vimim_toggle='pinyin'
let g:airline_powerline_fonts=1
"let g:airline_theme='solarized'
set noshowmode
set laststatus=2

let g:ctrlp_extensions = ['tag']

let g:session_autosave='yes'
let g:session_autoload='no'


let NERDTreeIgnore=['__pycache__', '\.pyc$', '\.lo$', '\.o$', '\.la$', '^tags']
"let NERDTreeWinPos='right'
let g:nerdtree_tabs_open_on_console_startup = 0
let g:startify_disable_at_vimenter = 1

let g:miniBufExplVSplit = 20
let g:miniBufExplBRSplit = 1
let g:miniBufExplAutoStart = 0
let g:miniBufExplCycleArround = 1

set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 4
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_python_checkers = ['pylint']
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '!'
"let g:syntastic_mode_map = {
"        \ "mode": "passive",
"        \ "active_filetypes": [],
"        \ "passive_filetypes": [] }

let g:SimpylFold_docstring_preview = 1

let g:tagbar_compact = 1
let g:tagbar_show_linenumbers = 1
nnoremap <C-l> :Tagbar<cr>
nnoremap <C-]> g<C-]>

let g:flake8_show_in_gutter = 1
if !executable('flake8') " workaround for toutiao machine
    let g:flake8_cmd="/home/kongyifei.rocks/repos/ss_lib/python_package/lib/python2.7/site-packages/flake8"
endif

function! TrimWhiteSpace()
  %s/\s*$//
  ''
endfunction


"autocmd FileWritePre * call TrimWhiteSpace()
"autocmd FileAppendPre * call TrimWhiteSpace()
"autocmd FilterWritePre * call TrimWhiteSpace()
"autocmd BufWritePre * call TrimWhiteSpace()


noremap <F7> :SyntasticCheck<CR>
noremap <F8> :SyntasticReset<CR>

"autocmd BufWritePost *.py call Flake8() " automatically call flake8 when saving python files

let g:ctrlp_max_files=0 " by default, ctrlp only caches 60,000 files
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'
let g:ctrlp_follow_symlinks=1
let g:ctrlp_match_window = 'min:4,max:10,results:100'


let g:ag_lhandler="botleft lopen"
let g:ale_python_pylint_options = '--rcfile=~/.pylintrc'

runtime macros/matchit.vim

call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'posva/vim-vue'
"Plug 'nathanaelkane/vim-indent-guides'  " show indent guides
Plug 'ConradIrwin/vim-bracketed-paste'  " automatically escape paste, prevent from incorrect result, not working
"Plug 'christoomey/vim-tmux-navigator'
Plug 'mhinz/vim-startify'  " show a more useful start page
"Plug 'whatyouhide/vim-gotham' " Code never sleeps in gotham city
Plug 'altercation/vim-colors-solarized'  " current colorscheme
"Plug 'tomasr/molokai'
Plug 'bling/vim-airline'  " the status bar
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-surround' " causing clipboard issue
Plug 'vim-scripts/vimim'
"Plug 'ryanss/vim-hackernews' " bugs
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-session'
"Plug 'tmhedberg/SimpylFold'
"Plug 'vim-scripts/Conque-GDB' " not compatiable with vim-plug
"Plug 'Rip-Rip/clang_complete'
Plug 'ervandew/supertab'
"Plug 'klen/python-mode'
"Plug 'junegunn/vim-easy-align' " I literally don't know how to use
"Plug 'godlygeek/tabular'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mattn/emmet-vim'  " expand html tags
"Plug 'fholgado/minibufexpl.vim'
Plug 'rking/ag.vim'  " need to install ag
"Plug 'scrooloose/syntastic'  " syntastic checking
Plug 'guns/xterm-color-table.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'kshenoy/vim-signature'
"Plug 'nvie/vim-flake8'
"Plug 'Yggdroot/indentLine'
Plug 'pelodelfuego/vim-swoop'
Plug 'solarnz/thrift.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'cakebaker/scss-syntax.vim'
"Plug 'vim-python/python-syntax'
Plug 'alvan/vim-php-manual'
Plug 'ludovicchabant/vim-gutentags' " need to install exburtan-tags
Plug 'majutsushi/tagbar'
Plug 'rust-lang/rust.vim'
Plug 'w0rp/ale'
if has('python')
    Plug 'ashisha/image.vim'
endif
if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Valloric/YouCompleteMe'
endif


call plug#end()

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><tab>"
let g:jedi#use_tabs_not_buffers=1
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']
let g:vim_json_syntax_conceal = 0  " stupid indentline setting json conceals

autocmd FileType python setlocal completeopt-=preview " disable doc window in jedi-vim
autocmd Filetype json let g:indentLine_setConceal = 0

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
noremap <leader>] :tabnext<CR>
noremap <leader>[ :tabprevious<CR>
noremap <leader>+ :tabedit<CR>:Startify<CR>
noremap <leader>h :Startify<CR>

noremap <leader>r :source ~/.vimrc<CR>
noremap <leader>R :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
noremap <leader>v :tabe ~/.vimrc<CR>
noremap <leader><Space> :noh<CR>
noremap <leader>q :wq<CR>
noremap <leader>a :Ag<Space>
noremap <leader>m :MBEToggle<cr>
noremap <leader>S :set spell!<CR>
noremap <leader>a :Ag! -Q <C-r>=expand('<cword>')<CR><CR>

noremap <leader><leader> :NERDTreeToggle<CR>
noremap <leader>u :UltiSnipsEdit<CR>
noremap <leader>c :ccl<CR>

noremap <leader>i :IndentLinesToggle<cr>
vmap <leader>y :w! /tmp/vim_clipboard<CR>
nmap <leader>p :r! cat /tmp/vim_clipboard<CR>

noremap <leader>j :%!python3 ~/.dotfiles/format_json.py<cr>
inoremap <C-u> <esc>viwUi
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>
nnoremap <leader>t call TrimWhiteSpace()<cr>
nnoremap <leader>s set paste!<cr>

" like tmux
noremap <C-w>m <C-w>\|
noremap <C-w>M <C-w>_
noremap <C-w>\| <C-w>v
noremap <C-w>- <C-w>s

noremap <F3> :%s/
noremap g<F3> :s/

nnoremap / /\v
vnoremap / /\v


noremap <F1> <esc>


noremap <C-j> 5j
noremap <C-k> 5k

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


" close nerdtree on open file
let NERDTreeQuitOnOpen=1
" close nerdtree on quit vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"colo gotham256 " colorscheme depends on plugins
"set background=dark
colo solarized
hi Folded ctermbg=NONE guibg=NONE " I just don't like the folded line to be hied


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

