if [ -e ~/.ssh/aliases ]; then
    source ~/.ssh/aliases
fi

stty stop undef

# zsh setting
autoload -U compinit     # 補完機能の強化
compinit

setopt auto_menu            # TAB で順に補完候補を切り替える
setopt auto_pushd           # 自動でpushd 
setopt append_history       # 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt hist_ignore_dups     # 直前と同じコマンドラインはヒストリに追加しない
setopt hist_ignore_space    # コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt share_history        # シェルのプロセスごとに履歴を共有
setopt hist_no_store        # history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_verify          # ヒストリを呼び出してから実行する間に一旦編集できる状態になる
setopt auto_cd              # ディレクトリ名を打つだけでcd
setopt rm_star_silent       # rm * の確認をしない
setopt extended_glob        # ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_history     # 履歴ファイルに時刻を記録
setopt hist_ignore_all_dups # 既にヒストリにあるコマンド行は古い方を削除
setopt hist_reduce_blanks   # コマンドラインの余計なスペースを排除
setopt magic_equal_subst    # --prefix=/usr などの = 以降でも補完できる

unsetopt promptcr # 改行の無い出力を表示する

function history-all { history -E 1 } # 全履歴の一覧を出力する

# cd をしたときにlsを実行する
function chpwd() { clear;echo \[`pwd`\];ls -l }

zstyle ':completion:*:default' menu select=1 # 補完候補のカーソル選択を有効に

#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8
export EDITOR=vim
#export PAGER='less -N'

bindkey -e
bindkey '^R' history-incremental-search-backward

#PROMPT='[%n@%m]%# '
#RPROMPT='[%~]'

PROMPT="[%B%~${default}%b] %E
%b%# "
RPROMPT='[%n@%m]'


### history setting
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

### my aliases
alias fin='find . -name'
alias l=clear
alias la='ls -a'
alias le=less
alias ll='ls -l'
alias m=more
alias man='LANG=ja_JP.UTF-8 man'
alias rb=ruby
alias sc=screen
alias w3m='w3m -no-mouse'
alias vi=vim
alias -g G='| grep'
alias -g L='| less'
alias -g V='| grep -v'
alias -g W='| wc'
alias -g X='| xargs grep'

## svn
alias si='svn ci'
alias sl='svn diff | less'
alias so='svn co'
alias st='svn st'
alias up='svn up'


## screen auto run
#if [ $SHLVL = 1 ];then
#      screen -R
#fi

# vi open perl file
vip () {
    vi `perldoc -ml $1 | perl -pe 's/pod$/pm/'`
}

# cd module dist
cdp () {
    cd `perldoc -ml $1 | perl -pe 's!\.\w+$!/!'`
}

# status bar
preexec () {
    if [ $TERM = "screen" ]; then
        1="$1 " # deprecated.
        echo -ne "\ek${${(s: :)1}[0]}\e\\"
    fi
}

# add PATH
PATH=$PATH:/sbin:/usr/sbin:~/bin

export PERL_AUTOINSTALL="--defaultdeps"
export DBIC_NO_WARN_BAD_PERL=1

alias pv='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} }'"'"
