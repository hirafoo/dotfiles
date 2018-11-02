set nocompatible
filetype off

" gocode
set rtp+=$GOROOT/misc/vim

" vundle
set rtp+=~/.vim/vundle/
call vundle#rc()

Bundle 'cecutil'
Bundle 'closetag.vim'
Bundle 'FuzzyFinder'
Bundle 'L9'
Bundle 'dumbbuf'
Bundle 'HTML5-Syntax-File'
Bundle 'IndentAnything'
Bundle 'Javascript-Indentation'
Bundle 'Align'
Bundle 'hotchpotch/perldoc-vim'
Bundle 'vim-perl/vim-perl'
Bundle 'koron/dicwin-vim'
Bundle 'AutoComplPop'
Bundle 'ack.vim'
Bundle 'Blackrush/vim-gocode'
Bundle 'YankRing.vim'
Bundle "rhysd/ghpr-blame.vim"
Bundle "tyru/current-func-info.vim"

syntax on
filetype indent plugin on

"set cursorline
set ambiwidth=double
set tabstop=4
set tenc=utf8
set enc=utf8
set shiftwidth=4
set expandtab
set showmode
set ai
"set showmatch
set hlsearch
set incsearch
set laststatus=2
"set showcmd
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
"set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ %m%h%r=%l/%L,%c%V\ %P
"set statusline=%y%{GetStatusEx()}\ %m%h%r%l/%L,%c%V\ %P
set statusline=%{GetStatusEx()}%y\ %m%h%r%l/%L,%c\ %P
set backspace=indent,eol,start
set helplang=ja,en
set fileformats=unix,dos,mac
set nofoldenable "折り畳み無効
set hidden

highlight ZenkakuSpace cterm=underline ctermfg=lightblue
match ZenkakuSpace /　/

" ポップアップメニューのカラーを設定
hi Pmenu ctermbg=4
hi PmenuSel ctermbg=1
hi PMenuSbar ctermbg=4

" htmlモードとかで閉じタグをc--で自動挿入
let g:closetag_html_style=1
"カッコをハイライトしない
let loaded_matchparen=1

nnoremap BD :bd<CR>
nnoremap W :w<CR>
nnoremap Y y$
noremap <C-j> :bprev!<CR>
noremap <C-k> :bnext!<CR>

"xで削除した文字をレジスタに入れない
"nnoremap x "_x

map <C-C> <Esc>
cmap qq q!
nmap <silent> <C-L> <C-L>:noh<CR>

"インサートモードで移動
noremap! <C-h> <Left>
noremap! <C-l> <Right>
noremap! <C-k> <Up>
noremap! <C-j> <Down>
noremap! <C-a> <Home>
noremap! <C-e> <End>

inoremap <silent> <expr> <C-e>  (pumvisible() ? "\<C-e>" : "\<End>")

noremap! <C-d> <Del>

"括弧を打ったら自動で閉じる
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"vnoremap { "zdi^V{<C-R>z}<ESC>
"vnoremap [ "zdi^V[<C-R>z]<ESC>
"vnoremap ( "zdi^V(<C-R>z)<ESC>
"vnoremap " "zdi^V"<C-R>z^V"<ESC>
"vnoremap ' "zdi'<C-R>z'<ESC>

" :vim[grep] の結果を quickfix で開く
autocmd QuickFixCmdPost *grep* cwindow

autocmd BufNewFile  *.pl      0r ~/.vim/template/perl.pl
autocmd BufNewFile  *.pm      0r ~/.vim/template/perl.pl
autocmd BufNewFile,BufRead *.sql set filetype=mysql

"insertを抜けたら保存
autocmd InsertLeave *  silent! wall

autocmd FileType perl set isfname-=-
autocmd FileType perl set isfname-=/

au Filetype html,xml,xsl,ant source ~/.vim/bundle/closetag.vim/plugin/closetag.vim
au FileType sql  set timeoutlen=0

augroup filetypedetect
au! BufRead,BufNewFile *.inc    setfiletype html
au! BufRead,BufNewFile *.tt     setfiletype html
au! BufRead,BufNewFile *.xhtml  setfiletype html
au! BufRead,BufNewFile *.erb    setfiletype ruby
au! BufRead,BufNewFile *.ru     setfiletype ruby
au! BufRead,BufNewFile *.t      setfiletype perl
au! BufRead,BufNewFile *.cgi    setfiletype perl
au! BufRead,BufNewFile *.psgi   setfiletype perl
au! BufRead,BufNewFile *.conf   setfiletype conf
augroup END

function! GetStatusEx()
    let str = &fileformat
    if has("multi_byte") && &fileencoding != ""
        let str = &fileencoding . ":" . str
    endif
    let str = "[" . str . "]"
    let str = cfi#format("[%s]", "") . str
    return str
endfunction

command! -bang -nargs=? Utf  edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis edit<bang> ++enc=sjis <args>
command! -bang -nargs=? Euc  edit<bang> ++enc=euc-jp <args>
command! -bang -nargs=? Iso  edit<bang> ++enc=iso-2022-jp <args>
command! -bang -nargs=? Unix set fileformat=unix
command! -bang -nargs=? Dos  set fileformat=dos
command! -bang -nargs=? Js   setfiletype javascript
command! -bang -nargs=? Html setfiletype html

"行末のスペースを可視化
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/
autocmd WinEnter * match WhitespaceEOL /\s\+$/

"""""""""""""""""""""""""""""""""plugin"""""""""""""""""""""""""""""""""

""""""""""""""""""""""""YankRing.vim
let g:yankring_history_dir = '/tmp/'

""""""""""""""""""""""""acp.vim
"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

",t で有効・無効
inoremap <expr> ,t
    \ (exists('#AcpGlobalAutoCommand#InsertEnter#*')) ? "<C-o>:AutoComplPopDisable<CR>" : "<C-o>:AutoComplPopEnable<CR>"

"候補選択後の改行の動作
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"
""""""""""""""""""""""""/acp.vim

""""""""""""""""""""""""dicwin.vim
"memo
"c-t k
"c-t n/p
"c-t w/c//

"発動キー
let g:mapleader = "\<C-t>"
""""""""""""""""""""""""/dicwin.vim

""""""""""""""""""""""""buftabs.vim
"バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1
""""""""""""""""""""""""/buftabs.vim

""""""""""""""""""""""""dumbbuf.vim
let g:dumbbuf_hotkey = "<C-o>"
""""""""""""""""""""""""/dumbbuf.vim

""""""""""""""""""""""""FuzzyFinder
nnoremap <silent> ee :FufFileWithCurrentBuffer!<CR>
""""""""""""""""""""""""/FuzzyFinder

""""""""""""""""""""""""Align
"矩形選択して Align =>
""""""""""""""""""""""""/Align

"";に続けて打つと大文字に
"let s:sticky_table = {
"\'a' : 'A', 'b' : 'B', 'c' : 'C', 'd' : 'D', 'e' : 'E', 'f' : 'F', 'g' : 'G',
"\'h' : 'H', 'i' : 'I', 'j' : 'J', 'k' : 'K', 'l' : 'L', 'm' : 'M', 'n' : 'N',
"\'o' : 'O', 'p' : 'P', 'q' : 'Q', 'r' : 'R', 's' : 'S', 't' : 'T', 'u' : 'U',
"\'v' : 'V', 'w' : 'W', 'x' : 'X', 'y' : 'Y', 'z' : 'Z',
"\'<ESC>' : '<ESC>', 'J' : ';<ESC>', '<Space>' : ';', '<CR>' : ';<CR>'
"\}
"inoremap ;  <Nop>
"cnoremap ;  <Nop>
"snoremap ;  <Nop>
"for key in keys(s:sticky_table)
"    execute 'inoremap ' (';'.key)  (s:sticky_table[key])
"    execute 'cnoremap ' (';'.key)  (s:sticky_table[key])
"    execute 'snoremap ' (';'.key)  (s:sticky_table[key])
"endfor
"unlet s:sticky_table

""" 文字コードの自動認識
"if &encoding !=# 'utf-8'
"  set encoding=japan
"  set fileencoding=japan
"endif
"if has('iconv')
"  let s:enc_euc = 'euc-jp'
"  let s:enc_jis = 'iso-2022-jp'
"  " iconvがeucJP-msに対応しているかをチェック
"  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'eucjp-ms'
"    let s:enc_jis = 'iso-2022-jp-3'
"  " iconvがJISX0213に対応しているかをチェック
"  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
"    let s:enc_euc = 'euc-jisx0213'
"    let s:enc_jis = 'iso-2022-jp-3'
"  endif
"  " fileencodingsを構築
"  if &encoding ==# 'utf-8'
"    let s:fileencodings_default = &fileencodings
"    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
"    let &fileencodings = &fileencodings .','. s:fileencodings_default
"    unlet s:fileencodings_default
"  else
"    let &fileencodings = &fileencodings .','. s:enc_jis
"    set fileencodings+=utf-8,ucs-2le,ucs-2
"    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
"      set fileencodings+=cp932
"      set fileencodings-=euc-jp
"      set fileencodings-=euc-jisx0213
"      set fileencodings-=eucjp-ms
"      let &encoding = s:enc_euc
"      let &fileencoding = s:enc_euc
"    else
"      let &fileencodings = &fileencodings .','. s:enc_euc
"    endif
"  endif
"  " 定数を処分
"  unlet s:enc_euc
"  unlet s:enc_jis
"endif
"" 日本語を含まない場合は fileencoding に encoding を使うようにする
"if has('autocmd')
"  function! AU_ReCheck_FENC()
"    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
"      let &fileencoding=&encoding
"    endif
"  endfunction
"  autocmd BufReadPost * call AU_ReCheck_FENC()
"endif

set rtp+=/usr/local/go/misc/vim
if filereadable( $HOME . "/.vimrc_after" )
  source ~/.vimrc_after
endif
