set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle "hexHighlight.vim"
Bundle "vim-coffee-script"
" original repos on github
Bundle "me-vlad/python-syntax.vim"
Bundle "flazz/vim-colorschemes"
Bundle "xolox/vim-misc"
Bundle "xolox/vim-colorscheme-switcher"
Bundle "scrooloose/syntastic"
Bundle "mustache/vim-mode"
Bundle "digitaltoad/vim-jade"
Bundle "groenewege/vim-less"
Bundle "plasticboy/vim-markdown"
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle "bling/vim-airline"
Bundle "lambdatoast/elm.vim"
Bundle "mustache/vim-mustache-handlebars"
Bundle "tpope/vim-unimpaired"
Bundle "kien/ctrlp.vim"
Bundle "rking/ag.vim"

" :PluginInstall  to install vundle plugins

filetype plugin indent on     " required for Vundle

" let g:syntastic_coffee_checkers = ['coffeelint']
" let g:syntastic_coffee_coffeelint_args = "--csv --file /Users/andy/src/Iverson/iverson/coffeelint.json"
let g:syntastic_mode_map = { "mode": "active", "passive_filetypes": ["html"] }
let g:airline_powerline_fonts = 1

"ctrlp stuff
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_root_markers=".ctrlp_root"

" ctrlp ignore gitignored files (https://github.com/kien/ctrlp.vim/issues/174)
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

if has("gui_running")
  colorscheme zmrok
  set listchars=tab:»\ ,eol:¬
else
  colorscheme desert
endif

let python_highlight_string_formatting = 1
let python_highlight_string_format = 1
let python_highlight_string_templates = 1

" put all swap files in the same place
set directory^=C:\temp,$HOME/.vim_swap//

syntax on

set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set expandtab

set smartcase " ignore case when pattern is all lowercase, sensitive otherwise
set hlsearch  " highlight search terms
set incsearch " show matches as you type
set visualbell "don't beep
set noerrorbells "don't beep

" keep 4 visible lines around the cursor always
set scrolloff=4

" status line
set statusline=%f%m%r%h%w\ [%Y\ %{&ff}]\ [%c\ %l/%L\ (%p%%)]
set laststatus=2

" line numbers
set number

" lets you switch out of unsaved buffers
set hidden

set fileformats=unix,dos

" ignore .class and .pyc files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.class,*.pyc
" bash style completion
set wildmode=longest,list,full
set wildmenu

" backspaces delete things
set backspace=2

" automagically save / restore folds
"au BufWinLeave *.* mkview
"au BufWritePost *.* mkview
"au BufWinEnter *.* silent loadview

" http://stackoverflow.com/questions/2019281/load-different-colorscheme-when-using-vimdiff
if &diff && has("gui_running")
  colorscheme jellybeans
endif

" show invisibles
set list

" remove tool, menu, and scroll bars from gvim
set guioptions-=m
set guioptions-=T
set guioptions+=Lrbl
set guioptions-=Lrbl

" enable alt space, perhaps even alt tab
set winaltkeys=yes

" mvim font
if has("mac")
	set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline:h11,Consolas:h10
endif

set gdefault " makes /g searches happen by default

set clipboard=unnamed " automatically yank to the windows clipboard

" & will Ag the current word
nmap & :Ag <cword><CR>

" Middle Mouse button pastes all the time on accident
" Apparently double / triple / quadruple middle mouse click also pastes
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

" F3 => tell me what highlight group it is
map <F3> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

nnoremap j gj
nnoremap k gk

" single char deletes don't update default register
noremap x "_x
" paste doesn't update default register
vnoremap p "_dP

" superfast commands
nnoremap ; :

let mapleader = ","
" ,/ => clear search buffer
nmap <silent> <LEADER>/ :let @/=""<CR>
" ,c => cd to current file
nmap <LEADER>c :lcd %:p:h<CR>
nmap <LEADER>C :cd %:p:h<CR>

" make space toggle folds
"nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
"vnoremap <Space> zf

" make Control Up and Down increase / decrease font size
nnoremap <C-Up> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)+1)',
 \ '')<CR>
nnoremap <C-Down> :silent! let &guifont = substitute(
 \ &guifont,
 \ ':h\zs\d\+',
 \ '\=eval(submatch(0)-1)',
 \ '')<CR>

" F12 => redo syntax highlighting
noremap <F12> <Esc>:syntax sync fromstart<CR>

" F11 => full screen
if has("gui_running")
	map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 
endif

function! SetTabWidth(width)
	set tabstop=a:width
	set softtabstop=a:width
	set shiftwidth=a:width
endfunction


if has("python")
" Let me use gf on python libraries
python << EOF
import os
import sys
import vim
for p in sys.path:
	if os.path.isdir(p):
		vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
EOF
endif

