set nocompatible
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
set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ %m%h%r=%l/%L,%c%V\ %P
set backspace=indent,eol,start 
:set helplang=ja,en

"dicwin memo
"c-d k
"c-d n/p
"c-d w/c//
" for buftabs.vim
"バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1

:let g:closetag_html_style=1 " htmlモードとかで閉じタグをc--で自動挿入
let loaded_matchparen = 1 "カッコをハイライトしない

noremap <C-j> :bprev!<CR>
noremap <C-k> :bnext!<CR>
nnoremap x "_x
map <C-C> <Esc>

:map <silent> <C-o> :call BufferList()<CR>
:cmap qq q!
"inoremap PP use Data::Dumper;sub p {warn Dumper @_;my @c = caller;print STDERR "  at $c[1]:$c[2]\n\n"}<CR>
imap PP use Data::Dumper;sub p {warn Dumper @_;my @c = caller;print STDERR "  at $c[1]:$c[2]\n\n"}<CR>

"インサートモードで移動
noremap! <C-h> <Left>
noremap! <C-l> <Right>
noremap! <C-k> <Up>
noremap! <C-j> <Down>
noremap! <C-a> <Home>
noremap! <C-e> <End>
inoremap <silent> <expr> <C-e>  (pumvisible() ? "\<C-e>" : "\<End>")
noremap! <C-d> <Del>
nmap <silent> <C-L> <C-L>:noh<CR>

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

autocmd BufNewFile  *.pl      0r ~/.vim/template/perl.pl
autocmd BufNewFile  *.pm      0r ~/.vim/template/perl.pm
autocmd BufNewFile  *.t       0r ~/.vim/template/perl_test.t

autocmd InsertLeave *  silent! wall

au Filetype html,xml,xsl,ant source ~/.vim/plugin/closetag.vim

augroup filetypedetect
au! BufRead,BufNewFile *.tt     setfiletype html
au! BufRead,BufNewFile *.xhtml  setfiletype html
au! BufRead,BufNewFile *.erb    setfiletype ruby
au! BufRead,BufNewFile *.ru     setfiletype ruby
au! BufRead,BufNewFile *.t      setfiletype perl
au! BufRead,BufNewFile *.cgi    setfiletype perl
au! BufRead,BufNewFile *.conf   setfiletype conf
augroup END

function! GetStatusEx()
let str = &fileformat
    if has("multi_byte") && &fileencoding != ""
        let str = &fileencoding . ":" . str
    endif
    let str = "[" . str . "]"
    return str
endfunction

syntax on

filetype on
filetype indent on
filetype plugin on

command! -bang -nargs=? Utf
            \ edit<bang> ++enc=utf-8 <args>
command! -bang -nargs=? Sjis
            \ edit<bang> ++enc=sjis <args>
command! -bang -nargs=? Euc
            \ edit<bang> ++enc=euc-jp <args>

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

"" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
