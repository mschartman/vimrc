"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible | filetype indent plugin on | syn on
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'
  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
      execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {})
endfun

call SetupVAM()
VAMActivate matchit.zip vim-addon-commenting
VAMActivate ag
VAMActivate github:junegunn/fzf
VAMActivate github:junegunn/fzf.vim
VAMActivate github:sjl/gundo.vim
VAMActivate mustache
VAMActivate github:scrooloose/nerdtree
VAMActivate github:vim-syntastic/syntastic
VAMActivate tComment
VAMActivate tlib
VAMActivate vcscommand
VAMActivate vim-addon-mw-utils
VAMActivate vim-classpath
VAMActivate vim-clojure-static
VAMActivate Solarized
VAMActivate dispatch
VAMActivate EasyMotion
VAMActivate endwise
VAMActivate vim-fireplace
VAMActivate fugitive
VAMActivate Indent_Guides
VAMActivate liquid
VAMActivate github:jistr/vim-nerdtree-tabs
VAMActivate rails
VAMActivate snipmate
VAMActivate vim-snippets
VAMActivate surround
VAMActivate vroom
VAMActivate vim-coffee-script
VAMActivate vim-slime
VAMActivate github:tpope/vim-rake
VAMActivate github:tpope/vim-bundler
VAMActivate github:othree/html5.vim
VAMActivate github:pangloss/vim-javascript
VAMActivate github:isRuslan/vim-es6.git
VAMActivate github:mschartman/yartr
VAMActivate github:groenewege/vim-less

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open=1
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "0"}
let g:nerdtree_tabs_open_on_console_startup = 1
set clipboard=unnamed
set rtp+=~/.fzf
set iskeyword=@,?,!,_,48-57,192-255
set wildmode=longest:full
set ignorecase
set tags=./tags,tags;$HOME
let g:mustache_abbreviations = 1
set re=1 " change regex engine to fix ruby syntax slowness
set mouse=a
set backspace=indent,eol,start
au FocusLost * silent! wa " autosave
au SwapExists *.rb let v:swapchoice = 'e' " always edit by default when swap file exists
au SwapExists *.js let v:swapchoice = 'e'
au SwapExists *.css let v:swapchoice = 'e'
let g:ycm_key_list_select_completion = ['<C-j>']
let g:ycm_key_list_previous_completion = ['<C-k>']
set lazyredraw
autocmd BufLeave,CursorHold,CursorHoldI,FocusLost * silent! wa
" These change the vim regex to not escape certain characters different than perl/python
" nnoremap / /\v
" cnoremap s/ s/\v

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guifont=Inconsolata-dz\ for\ Powerline:h12
if !has('nvim')
    set encoding=utf-8    " Necessary to show Unicode glyphs
endif
set t_Co=256          " Explicitly tell Vim that the terminal supports 256 colors
colorscheme solarized
set background=dark   " Use the dark version of the colorscheme
set number            " Line numbers
set foldlevel=99      " by default do not fold anything
set guioptions-=L
set guioptions-=r 
set guicursor+=n-v-c:blinkon0
set cursorline cursorcolumn
au WinLeave * set nocursorline
au WinEnter * set cursorline
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
au BufEnter,BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
au FileType ruby setl sw=2 sts=2 et 
au FileType css setl sw=2 sts=2 et 
au FileType html setl sw=2 sts=2 et 
au FileType eruby setl sw=2 sts=2 et 
au FileType javascript setl sw=2 sts=2 et 
au FileType yaml setl sw=2 sts=2 et 
filetype plugin indent on
set scrolloff=10

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status Bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
set statusline=
set statusline +=%2*[%n]\ %*                   " buffer number
set statusline +=%2*%m%*                       " modified flag
set statusline +=%1*\ %<%F%*                   " full path
set statusline +=%1*\ %{fugitive#statusline()} " git branch
set statusline +=%1*%=%5l%*                    " current line
set statusline +=%2*/%L%*                      " total lines
set statusline +=%1*%4v\ %*                    " virtual column number

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-k> :exec("ltag ".expand("<cword>"))<CR>:lopen<CR><CR>
map <D-R> :.Rake<cr>
map <D-/> :TComment<cr>
map <C-c> :.!pbcopy<cr>u
nnoremap gr gT
map <Leader>/ :TComment<cr>
map <Leader>h :noh<cr>
nmap <c-p> :FZF<cr>
nmap <c-n> :Buffers<cr>
nmap <Space> :BLines<cr>
noremap <Leader>rc :source ~/.config/nvim/init.vim<CR>
nmap <C-]> <C-w><C-]><C-w>T
nmap <C-t> :AT<cr>
nnoremap <leader>fn :let @*=expand("%:t")<CR> " copy current relative file name to system clipboard
nnoremap <leader>fp :let @*=expand("%:p")<CR> " copy current absolute file name to system clipboard
nmap <C-f> :NERDTreeFind<CR>
nmap <c-m> <Plug>(easymotion-s)
map <Leader>n <plug>NERDTreeTabsToggle<CR>
nnoremap <Leader>gu :GundoToggle<CR>
map <Leader>rh :s/:\([^ ]*\)\(\s*\)=>/\1:/g<CR>
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>
