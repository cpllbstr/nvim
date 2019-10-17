    "minimal neovim configuration for go
"
    " deoplete requires neovim, so this will not work with regulr vim
" prereqs:
" - neovim
" - neovim python3 (pip3 install --upgrade neovim)
"
" includes:
" - goimports on save (using vim-go)
" - auto-completion (using deoplete)"
" First install vim-plug:
" curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"
" Then save this file as ~/.config/nvim/init.vim

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif


set encoding=UTF-8

if &compatible
  set nocompatible
endif
let g:mapleader = ","
" deoplete
set completeopt=longest,menuone " auto complete setting
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns['default'] = '\h\w*'
let g:deoplete#omni#input_patterns = {}
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#gocode_binary = '/home/lbstr/go/bin/gocode'
let g:deoplete#sources#go#unimported_packages = 0
let g:deoplete#sources#go#cgo#libclang_path =  '/usr/lib/llvm-8/lib/libclang-8.so.1'
set runtimepath+=~/.config/nvim/plugged/deoplete.nvim/
set runtimepath+=~/.config/nvim/plugged/deoplete-clang/
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"


" Cpp highlight
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1


" vim-go
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_term_enabled = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls= 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1

" use real tabs in .go files, not spaces
autocmd FileType go setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab
"___________________
" PLUGINS
"___________________
call plug#begin()

Plug 'tpope/vim-fugitive'
Plug 'sebdah/vim-delve'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'jistr/vim-nerdtree-tabs'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } " Golang suppor in nvim (goimpoits, gofmt and etc)
" DEOPLETE
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Root autocompletion Plugin
Plug 'zchee/deoplete-go', { 'do': 'make' }     " Golang autocompletion
Plug 'zchee/deoplete-jedi'                     " Go auto completion
Plug 'zchee/deoplete-clang'                    " C and C++ autocompletion
Plug 'Shougo/neoinclude.vim'                   " For C and C++ include autocompletion
Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'bfrg/vim-cpp-modern'

Plug 'sbdchd/neoformat'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'ryanoasis/vim-devicons'
"Brackets
Plug 'luochen1990/rainbow'
Plug 'jiangmiao/auto-pairs'
" Colorscheme
Plug 'rafi/awesome-vim-colorschemes'
Plug 'nanotech/jellybeans.vim', { 'tag': 'v1.6' }
Plug 'jacoborus/tender.vim'
Plug 'phanviet/vim-monokai-pro'
Plug 'vim-airline/vim-airline-themes'
Plug 'terryma/vim-multiple-cursors'
Plug 'skielbasa/vim-material-monokai'
Plug 'patstockwell/vim-monokai-tasty'


Plug 'w0rp/ale'
Plug 'junegunn/goyo.vim'


" Add plugins to &runtimepath
call plug#end()

" install missing plugins on start
autocmd VimEnter *
 \  if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
 \|   PlugInstall
 \| endif
call deoplete#custom#source('_', 'converters',
      \ ['converter_auto_paren',
      \  'converter_auto_delimiter',
      \  'converter_remove_overlap'])
" mappings
:map <C-o> :e . <Enter>
:map <C-s> <Esc> :w <Enter>                                                    
:map <C-c> y                                                           
:map <C-v> p  
:map <C-x> d 
:map <C-z> u 
:map <C-t> :tabnew <Enter>                                           
:map <C-i> >>  
:map <C-k> :wqa! <Enter>                                                    
:map <C-q> :q  <Enter>
:map <C-h> :%s/
:map <S-t> vat                                                         
:map <S-T> vit      
:map <S-{> vi{        
:map <S-(> vi(      
:map <S-[> vi[ 
noremap <tab> <C-w>
:tnoremap <Esc> <C-\><C-n>
noremap <A-e> :NERDTreeToggle<CR>
nnoremap <Left> h
nnoremap <Right> l
nnoremap <Up> k
nnoremap <Down> j
set <down>=^[OB
set <right>=^[OC
set <left>=^[OD
nnoremap <C-Left> :tabprevious <Enter>
nnoremap <C-Right> :tabnext <Enter>
nnoremap <A-Left> :bn <Enter>
nnoremap <A-Right> :bp <Enter>
" deoplete
imap <expr> <Down>   pumvisible() ? "\<c-n>" : "\<tab>"
imap <expr> <Up> pumvisible() ? "\<c-p>" : "\<tab>"
imap <expr> <tab>    pumvisible() ? deoplete#close_popup() : "\<cr>"
" vim-go mappings
autocmd FileType go nmap <buffer> <leader>r <plug>(go-run)
autocmd FileType go nmap <buffer> <leader>b <plug>(go-build)
autocmd FileType go nmap <buffer> <leader>t <plug>(go-test)
autocmd FileType go nmap <buffer> <leader>e <plug>(go-rename)
autocmd FileType go nmap <buffer> gd <plug>(go-def-vertical)
autocmd FileType go nmap <buffer> <c-]> <plug>(go-def-vertical)
autocmd FileType go nmap <buffer> <leader>i <plug>(go-info)

"GENERAL SETTIGNS
"_______________________________________
"
if (has("termguicolors"))
     set termguicolors
endif
" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=0
" Theme
syntax enable
colorscheme monokai_pro


"DEOPLETE
"
if has('nvim')
    " Enable deoplete on startup
    let g:deoplete#enable_at_startup = 1
    let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-8/lib/libclang-8.so.1'
    let g:deoplete#source#clang#clang_header = '/usr/include/clang/8/include/'
endif

if has('mouse')
set mouse=a 
endif
set autoindent                    " take indent for new line from previous line       
set smartindent                   " enable smart indentation                          
set autoread                      " reload file if the file changes on the disk       
set autowrite                     " write when switching buffers                      
set autowriteall                  " write on :quit                                    
set clipboard=unnamedplus  
set colorcolumn=100                " highlight the 80th column as an indicator         
set completeopt-=preview          " remove the horrendous preview window              
set cursorline                    " highlight the current line for the cursor
set encoding=utf-8 
set expandtab                     " expands tabs to spaces                 
set list                          " show trailing whitespace               
set listchars=tab:\|\ ,trail:·                                                 
set nospell                       " disable spelling                          
set noswapfile                    " disable swapfile usage               
set nowrap     
set noerrorbells                  " No bells!                              
set novisualbell                  " I said, no bells!                     
set number                        " show number ruler                       
set relativenumber                " show relative numbers in the ruler    
set number
set number relativenumber
set ruler     
set formatoptions=tcqronj         " set vims text formatting options     
set softtabstop=2                                                          
set tabstop=2   
set title                         " let vim set the terminal title              
set updatetime=1                " redraw the status bar often                   
set tabstop=4   
set shiftwidth=4                                                         
set expandtab         
set nu  

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 28
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "|" " \x07
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>


" TERMINAL TOGGLE
let g:term_buf = 0
function! Term_toggle()
  1wincmd w
  if g:term_buf == bufnr("")
    setlocal bufhidden=hide
    close
  else
    rightbelow new
    17winc -
    try
      exec "buffer ".g:term_buf
    catch
      call termopen("bash", {"detach": 0})
      let g:term_buf = bufnr("")
  endtry
    set laststatus=0
    startinsert!
  endif
endfunction
nnoremap <A-a> :call Term_toggle()<cr>

" Error and warning signs.
let g:ale_sign_error = ''
let g:ale_sign_warning = '⚠'
" Enable integration with airlin
let g:airline#extensions#ale#enabled = 1



if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_theme='bubblegum'


"RAINBOW BRACKETS
let g:rainbow_active = 1
