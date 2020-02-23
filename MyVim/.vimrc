" 本配置主要参考慕课网PegasusWang的《玩转Vim 从放弃到爱不释手》课程进行配置
" 该课程免费系统的介绍vim的操作和简单配置，非常适合初学者和DIY入门者
" 课程链接：https://www.imooc.com/learn/1129
" 本配置主要是针对C代码的设置，其中YouCompleteMe的插件当前可以用，但是不是特别好

" 常用设置

" 1> 设置行号
set nu

" 2> 设置自动缩进
" set autoindent

" 3> 设置类似C语言的缩进
set cindent

" 4> 设置Tab长度为四个空格长度
set tabstop=4

" 5> 设置用空格代替Tab
set expandtab
%retab!

" 6> 设置Makefile的Tab不用空格替换
autocmd FileType make setlocal noexpandtab

" 7> 设置自动缩进的长度以4个空格为单位
set shiftwidth=4

" 8> 设置显示Tab为>---空格为.行尾多余的空格为$行尾结束符设置为eol，一般不设置
" set list
" set listchars=tab:>-,space:.,trail:$

" 9> 设置语法高亮
syntax on
set t_Co=256

" 10> 设置高亮搜索
set hlsearch

" 11> 按F2进入粘贴模式
set pastetoggle=<F2>

" 12> 设置折叠方式，不推荐使用
" set foldmethod=indent

" 背景色设置
" 1> 设置背景色
" set background=light
set background=dark

" 2> 选择主题色彩，在~/.vim/colors里，这里选择的是两种主题搭配使用
" colorscheme hybrid
" colorscheme solarized
colorscheme warriors-away
colorscheme vorange
" colorscheme gruvbox

" 映射设置
" 1> leader 键设置，一般设置为,
let mapleader=','
let g:mapleader=','

" 2> 设置自动补全括号，标准格式
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap < <><ESC>i
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
" inoremap } <c-r>=CloseBracket()<CR>
inoremap } <c-r>=ClosePair('}')<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endf

function CloseBracket()
    if match(getline(line('.') + 1), '\s*}') < 0
        return "\<CR>}"
    else
        return "\<Esc>j0f}a"
    endif
endf

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "\\"
        return a:char
    elseif line[col - 1] == a:char
        return "\<Right>"
    else
        return a:char.a:char."\<Esc>i"
    endif
endf

" 3> 设置{回车、{;快捷键
inoremap {<Enter> {}<Esc>i<Enter><Esc>ko
inoremap {; {}<Esc>A;<Esc>hi<Enter><Esc>ko

" 4> 设置,m为main函数自动补全
inoremap <leader>m <Esc>ddOint<space>main(int<space>argc,<space>char<space>*argv[])<Enter>{}<Esc>i<Enter><Esc>koreturn<space>0;<Esc>ko

" 5> 设置jj进入normal模式，`^表示退出normal模式后光标位置不变
inoremap jj <Esc>`^

" 6> 设置-同x一样为删除键
nnoremap - x

" 7> 设置空格键为进入visual模式并选中当前单词
map <space> viw

" 8> 设置insert模式下,d为删除当前行，和<Ctrl+u>功能类似
inoremap <leader>d <Esc>ddO

" 9> 设置使用,w直接保存
inoremap <leader>w <Esc>:w<cr>
noremap <leader>w :w<cr>

" 10> 切换buffer映射操作
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> [n :bnext<CR>

" 11> 设置切屏映射，use ctrl+h/j/k/l switch window
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" 12> disable上下左右键，慎选
" noremap <Up> <Nop>
" noremap <Down> <Nop>
" noremap <Left> <Nop>
" noremap <Right> <Nop>

" 13> 设置Sudo to write，即如果对文件没有写权限时切换到sudo模式写
cnoremap w!! w !sudo tee % >/dev/null

" json 格式化
com! FormatJSON %!python3 -m json.tool

" 插件管理

" 插件设置，这里使用了vim-plug
call plug#begin('~/.vim/plugged')

" 安装插件只需要把github地址放到这里重启后执行：plugInstall就好了
Plug 'mhinz/vim-startify'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'flazz/vim-colorschemes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'brooth/far.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'majutsushi/tagbar'
Plug 'lfv89/vim-interestingwords'
Plug 'Valloric/YouCompleteMe'
" Plug 'sbdchd/neoformat'
" Plug 'w0rp/ale'
Plug 'tpope/vim-commentary'


call plug#end()

" 插件相关配置
" 禁止startify自动切换目录
let g:startify_change_to_dir = 0
let g:go_version_warning = 0
" 设置缩进线的符号
let g:indentLine_char = '┊'
" nerdtree
nmap ,v :NERDTreeFind<cr>
nmap ,g :NERDTreeToggle<cr>
nmap ss <Plug>(easymotion-s2)
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" python-mode set
" let g:pymode_python = 'python3'
" let g:pymode_trim_whitespaces = 1
" let g:pymode_doc=1
" let g:pymode_doc_bind = 'k'
" let g:pymode_rope_goto_definition_bind = "<C-]>"
" let g:pymode_lint = 1
" let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']
" let g:pymode_options_max_line_length = 120

" tagbar set
nnoremap <leader>t :TagbarToggle<cr>
inoremap <leader>t <Esc>:TagbarToggle<cr>

" interestingwords set
nmap mm <leader>k
imap <leader>k <Esc><leader>k

" tpope/vim-commentary set
nmap == gcc
" nmap = gcgc

" YouCompleteMe set
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_show_diagnostics_ui = 0 " 关闭诊断信息
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2  " 两个字符触发 补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1 " 收集
let g:ycm_complete_in_strings=1


