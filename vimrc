"*******************************************************************************
"*                                   common                                    *
"*******************************************************************************

set nocompatible              " be improved
set t_Co=256                  " 256 color display
set t_ut=                     " no terminal color bleeding in tmux
set history=1000
set autoread                  " auto reload when modified by other apps
set showmode
set showcmd
set shortmess=I
set wildmenu
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.o
set visualbell
set cursorline
set lazyredraw
set backspace=indent,eol,start
set nofoldenable
set conceallevel=0
set ttyfast
set completeopt=longest,menu  " vim tip 1228

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
set formatoptions+=m " 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=B " 合并两行中文时，不在中间加空格
set foldmethod=indent
set foldnestmax=99
set textwidth=80
set formatoptions=qrn1
set colorcolumn=81         " 81th column colored
set list
set listchars=tab:▸\ ,trail:·,extends:>,precedes:<
au FileType go set listchars=tab:\ \ ,trail:·,extends:>,precedes:<

set mouse=a

set magic

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
au Filetype json let g:indentLine_setConceal=0

" Search related
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch

"*******************************************************************************
"*                                   plugin                                    *
"*******************************************************************************

let &t_SI="\e[6 q"
let &t_EI="\e[2 q"
let g:vimim_cloud=-1
let g:vimim_toggle='pinyin'

let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
let g:airline#extensions#ale#enabled=1
set noshowmode
set laststatus=2

let g:ctrlp_extensions=['tag']
let g:ctrlp_max_files=0 " by default, ctrlp only caches 60,000 files
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore='\v[\/]\.(git|hg|svn|pyc)$'
let g:ctrlp_follow_symlinks=1
let g:ctrlp_match_window='min:4,max:10,results:100'

let NERDTreeIgnore=['__pycache__', '\.pyc$', '\.lo$', '\.o$', '\.la$', '^tags$']
let g:nerdtree_tabs_open_on_console_startup=0
let g:startify_disable_at_vimenter=1

set statusline+=%#warningmsg#
set statusline+=%*

let g:ag_lhandler="botleft lopen"

let g:ale_python_pylint_options='--rcfile=~/.pylintrc'

let g:UltiSnipsSnippetDirectories=['~/.vim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<nop>"
let g:ulti_expand_or_jump_res=0
function ExpandSnippetOrCarriageReturn()
    let snippet=UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

let g:vim_json_syntax_conceal=0  " stupid indentline setting json conceals

let g:indent_guides_guide_size=1
let g:indent_guides_enable_on_vim_startup=1

" close nerdtree on open file
let NERDTreeQuitOnOpen=1
" close nerdtree on quit vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" automatically align `|` seperated tables
" ref: http://vimcasts.org/episodes/aligning-text-with-tabular-vim/
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
    let p='^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column=strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position=strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

runtime macros/matchit.vim

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
" language related
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'posva/vim-vue'
Plug 'solarnz/thrift.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'alvan/vim-php-manual'
Plug 'rust-lang/rust.vim'
Plug 'tmhedberg/SimpylFold'  " pythonic fold
Plug 'sheerun/vim-polyglot'

" enhancements
Plug 'mhinz/vim-startify'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'  " <leader>t

" prompt
Plug 'junegunn/fzf', { 'dir': '~/.fzf'}  " install in ~/.fzf and only for vim
Plug 'junegunn/fzf.vim'  " full fzf support in vim
Plug 'w0rp/ale'
if has('python') || has('python3')
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'Valloric/YouCompleteMe'
    " need to call ~/.vim/plugged/YouCompleteMe/install.py --clang-completer --go-completer --js-completer
endif

" colors
Plug 'whatyouhide/vim-gotham' " Code never sleeps in gotham city
Plug 'altercation/vim-colors-solarized'  " current colorscheme
Plug 'tomasr/molokai'

" misc
Plug 'tpope/vim-commentary'  " gc<motion> to comment
Plug 'kshenoy/vim-signature'
Plug 'vim-scripts/vimim'
Plug 'guns/xterm-color-table.vim'
Plug 'ludovicchabant/vim-gutentags' " need to install exburtan-tags
Plug 'godlygeek/tabular'
au FileType python Plug 'nathanaelkane/vim-indent-guides'
Plug 'vim-scripts/vim-hackernews'
if has('python')
    Plug 'ashisha/image.vim'
endif
call plug#end()

"set background=dark
colo solarized  " colorscheme depends on plugins
hi Folded ctermbg=NONE guibg=NONE " I just don't like the folded line to be hied

"*******************************************************************************
"*                                   mappings                                  *
"*******************************************************************************

" sudo related
cmap w!! w !sudo tee %
cmap x!! w !sudo tee %<CR><CR>:q!<CR>

" tab related
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
let g:last_active_tab = 1
nnoremap <silent> <leader>p :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

noremap <leader><leader> :tabnext<CR>
noremap <leader>] :tabnext<CR>
noremap <leader>[ :tabprevious<CR>
noremap <leader>+ :tabedit<CR>:Startify<CR>
noremap <leader>h :Startify<CR>  " h for home

" vimrc related
noremap <leader>r :source ~/.vimrc<CR>  " r for reload
noremap <leader>R :w<CR>:source ~/.vimrc<CR>:PlugInstall<CR>
noremap <leader>v :vsplit ~/.vimrc<CR>  " v for vimrc

function! TrimWhiteSpace()
    %s/\s*$//
    ''
endfunction

noremap <leader>a :Ag<Space>
noremap <leader>A :Ag! -Q <C-r>=expand('<cword>')<CR><CR>
au FileType python map <silent> <leader>b oimport ipdb; ipdb.set_trace()<esc>
au FileType python map <silent> <leader>B Oimport ipdb; ipdb.set_trace()<esc>
noremap <leader>c :cclose<CR>
nnoremap <leader>g :ALEGoToDefinition<CR>
nnoremap <leader>G :ALEGoToDefinitionInTab<CR>
nnoremap <leader>H :tabe<CR>:HackerNews<CR>
nnoremap <leader>i :IndentLinesToggle<CR>
nnoremap <leader>I :GoImports<CR>
nnoremap <leader>j :%!json_format<CR>  " rely on ~/.dotfiles/bin/json_format
nnoremap <leader>m :call TrimWhiteSpace()<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>q :wq<CR>
nnoremap <leader>s :set paste!<CR>
nnoremap <leader>S :set spell!<CR>
nnoremap <leader>u :UltiSnipsEdit<CR>
nnoremap <leader>t :Tagbar<CR>
nnoremap <leader>T :Tabularize
vnoremap <leader>T :Tabularize
nnoremap <leader><space> :noh<CR>

" fzf related
nnoremap gff :Files<CR>
nnoremap gfc :Commits<CR>
nnoremap gfa :Ag<CR>
nnoremap gfl :Lines<CR>
nnoremap gft :Tags<CR>
"nnoremap gfs :Snippets<CR>
imap <c-x><c-l> <plug>(fzf-complete-line)

" cross vim copy and paste
vmap <leader>y :w! /tmp/vim_clipboard<CR>
nmap <leader>p :r! cat /tmp/vim_clipboard<CR>

" panel related
noremap <F2> :NERDTreeToggle<CR>
noremap <F4> :Tagbar<CR>

" window related like tmux
noremap <C-w>m <C-w>\|
noremap <C-w>M <C-w>_

" enhancements
inoremap jk <Esc>  " very handy
inoremap <C-u> <esc>viwUi  " turn into uppercase
nnoremap <C-]> g<C-]>
noremap <F3> :%s/
noremap g<F3> :s/
nnoremap / /\v
vnoremap / /\v
noremap <F1> <esc>
noremap <C-j> 5j
noremap <C-k> 5k
inoremap <C-a> <HOME>
inoremap <C-e> <END>
vnoremap <C-a> ^
vnoremap <C-e> $
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
vnoremap < <gv
vnoremap > >gv

" close quick fix if it's last window
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
            \| exe "normal! g'\"" | endif

"*******************************************************************************
"*                                   neovim                                    *
"*******************************************************************************
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
    nnoremap <F6> :call Python_run()<CR>
endif

set guifont=Monaco\ for\ Powerline:h12
