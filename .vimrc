" for buftabs.vim
"バッファタブにパスを省略してファイル名のみ表示する(buftabs.vim)
let g:buftabs_only_basename=1
"バッファタブをステータスライン内に表示する
let g:buftabs_in_statusline=1
noremap <C-j> :bprev!<CR>
noremap <C-k> :bnext!<CR>

:map <silent> <C-o> :call BufferList()<CR>

" :qq で :q! と打った事にする
:cmap qq q!
"テンプレート読み込み
autocmd BufNewFile  *.pl      0r ~/.vim/template/perl.pl
autocmd BufNewFile  *.pm      0r ~/.vim/template/perl.pm
autocmd BufNewFile  *.t       0r ~/.vim/template/perl_test.t

autocmd InsertLeave *  silent! wall

" C-cをESCに
"↓は駄目
map <C-C> <Esc>

" インサートモードで移動
noremap! <C-h> <Left>
noremap! <C-l> <Right>
noremap! <C-k> <Up>
noremap! <C-j> <Down>
noremap! <C-a> <Home>
noremap! <C-e> <End>
inoremap <silent> <expr> <C-e>  (pumvisible() ? "\<C-e>" : "\<End>")
noremap! <C-d> <Del>

" htmlモードとかで閉じタグをc--で自動挿入
:let g:closetag_html_style=1
au Filetype html,xml,xsl,ant source ~/.vim/plugin/closetag.vim


""" 括弧を打ったら自動で閉じる
""inoremap { {}<LEFT>
""inoremap [ []<LEFT>
""inoremap ( ()<LEFT>
""inoremap " ""<LEFT>
""inoremap ' ''<LEFT>
""vnoremap { "zdi^V{<C-R>z}<ESC>
""vnoremap [ "zdi^V[<C-R>z]<ESC>
""vnoremap ( "zdi^V(<C-R>z)<ESC>
""vnoremap " "zdi^V"<C-R>z^V"<ESC>
""vnoremap ' "zdi'<C-R>z'<ESC>

" カッコをハイライトしない
let loaded_matchparen = 1

" 特定の拡張子を任意のファイルタイプに関連付ける
augroup filetypedetect
au! BufRead,BufNewFile *.tt     setfiletype html
au! BufRead,BufNewFile *.xhtml  setfiletype html
au! BufRead,BufNewFile *.erb    setfiletype ruby
au! BufRead,BufNewFile *.t      setfiletype perl
au! BufRead,BufNewFile *.cgi    setfiletype perl
augroup END

"☆とか※とかの対応
set ambiwidth=double

"set number
set tabstop=4
set shiftwidth=4
set expandtab
set showmode
set ai
set showmatch
set hlsearch
set incsearch
set laststatus=2
"set showcmd
"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

set statusline=[%n]\ %t\ %y%{GetStatusEx()}\ %m%h%r=%l/%L,%c%V\ %P
function! GetStatusEx()
let str = &fileformat
    if has("multi_byte") && &fileencoding != ""
        let str = &fileencoding . ":" . str
    endif
    let str = "[" . str . "]"
    return str
endfunction

nmap <silent> <C-L> <C-L>:noh<CR>

syntax on

filetype on
filetype indent on
filetype plugin on


"" 文字コードの自動認識
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
"" 改行コードの自動認識
"set fileformats=unix,dos,mac
"
"
