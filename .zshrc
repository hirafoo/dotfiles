if [ -e ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi
if [ -e ~/.zshrc_before ]; then
    source ~/.zshrc_before
fi

stty stop undef

# zsh setting
autoload -U compinit     # 補完機能の強化
compinit -u

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
WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

unsetopt promptcr # 改行の無い出力を表示する

# CVS ディレクトリへのcdを抑制
# http://www.cuspy.org/wiki/zsh-lovers
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
# cache
zstyle ':completion:*' use-cache true

#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8
#LANGUAGE=ja_JP:ja:en_GB:en
export LANGUAGE=en_US:en:en_GB:en
export EDITOR=vim
#export PAGER='less -N'
export LESS="-R"
export DBIC_NO_WARN_BAD_PERL=1
export MYSQL_PS1="[\R:\m:\s] (\U:\d)\nmysql> "

bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

#PROMPT='[%n@%m]%# '
#RPROMPT='[%~]'
PROMPT="[%B%~${default}%b] %E
%b%# "
#RPROMPT="[%n@%M]"

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|) [%n@%M]"

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

alias gb='git br'
alias gl='git di'
alias gn='git remote -v'
alias gi='git ci'
alias gu='git pull'
alias gp='git push'
alias go='git co'
alias gt='git st'
alias l=clear
alias la='ls -A'
alias le=less
alias ll='ls -l'
alias lla='ls -lA'
alias lld='ls -ld'
alias ls='ls --color=tty'
alias m=more
alias ja="export LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja:en_GB:en"
alias en="export LANG=en_US.UTF-8 LANGUAGE=en_US:en:en_GB:en"
alias jman='LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja:en_GB:en /usr/bin/man'
alias man='LANG=C man'
alias perldoc='perldoc -t'
alias pv='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} }'"'"
alias rb=ruby
alias sc=screen
alias sls="screen -ls"
alias sr="screen -r"
alias sx="screen -x"
alias w3m='w3m -no-mouse'
alias vi=vim
alias vie="vim -u ~/.vimrc_euc"
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tail'
alias -g U='| uniq'
alias -g V='| grep -v'
alias -g W='| wc'
alias -g X='| xargs grep'

alias si='svn ci'
alias sl='svn diff | colordiff | less'
alias so='svn co'
alias st='svn st'
alias up='svn up'

## screen auto run
#if [ $SHLVL = 1 ];then
#      screen -R
#fi

vip () {
    i=1;
    r=();
    for p in $@; do
        r[$i]=`perldoc -ml $p | perl -pe 's/pod$/pm/'`;
        i=$i+1;
    done
    vi $r;
}
cdp () { cd `perldoc -ml $1 | perl -pe 's/[^\/]+\.\w+$//'` }
cdpp () { cd `perldoc -ml $1 | perl -pe 's/\.pm$//'` }
vir () {
    i=1;
    r=();
    for p in $@; do
        r[$i]=`gem which $p`;
        i=$i+1;
    done
    vi $r;
}
cdr () { cd `gem which $1 | perl -pe 's/[^\/]+\.\w+$//'` }
fin () { find . -name $1 V svn }
history-all () { history -E 1 }
chpwd() { clear;echo \[`pwd`\];ls -l --color=tty }
optime() {
    cat /proc/uptime | awk '{print $1 / 60/60/24 " days / "$1/60/60" hour / " $1 " sec"}'
} # or use uptime(only BSD?)
vm ()     { man $1 | col -b | vi -R - }
jvm ()   { jman $1 | col -b | vi -R - }
pm () { perldoc $1 | col -b | vi -R - }

# status bar
#preexec () {
#    if [ $TERM = "screen" ]; then
#        1="$1 " # deprecated.
#        echo -ne "\ek${${(s: :)1}[0]}\e\\"
#    fi
#}

case "$TERM" in
xterm*|kterm*|rxvt*)
    # screenを起動してない時はここを通る
;;
screen*)
    # screen起動時はここを通る
    printf "\033P\033]0;$USER@$HOSTNAME\007\033\\"
;;
esac

PATH=~/bin:~/localbin:/sbin:/usr/sbin:/usr/local/bin:/var/lib/gems/1.8/bin:$PATH

if [ -e ~/.zshrc_after ]; then
    source ~/.zshrc_after
fi
