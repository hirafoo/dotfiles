load_if_exists () {
    if [ -e $1 ]; then
        #echo "load: $1"
        source $1
    #else
        #echo "no: $1"
    fi
}

load_if_exists "$HOME/.zshrc_local"
load_if_exists "$HOME/.zshrc_before"

stty stop undef

fpath=(~/.zsh/completion $fpath)

# zsh setting
autoload -U compinit     # 補完機能の強化
compinit -u

unset autologout

#zmv
autoload -Uz zmv

#url auto quote
#zsh-syntax-highlighting がうまく動かなくなる
#autoload -U url-quote-magic
#zle -N self-insert url-quote-magic

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
setopt prompt_subst         # PROMPT内で変数展開・コマンド置換・算術演算を実行する
setopt prompt_percent       # PROMPT内で「%」文字から始まる置換機能を有効にする
setopt transient_rprompt    # コピペしやすいようにコマンド実行後は右プロンプトを消す
setopt interactive_comments # コマンドラインでも # 以降をコメントと見なす
unsetopt promptcr           # 改行の無い出力を表示する

WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"

# CVS ディレクトリへのcdを抑制
# http://www.cuspy.org/wiki/zsh-lovers
zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'
# 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
# cache
zstyle ':completion:*' use-cache true
# 高速化らしい
zstyle ':completion:*' accept-exact '*(N)'
# 補完で大文字・小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

#export LANG=ja_JP.UTF-8
export LANG=en_US.UTF-8
#LANGUAGE=ja_JP:ja:en_GB:en
export LANGUAGE=en_US:en:en_GB:en
export EDITOR=vim
#export PAGER='less -N'
#export PAGER='less -S -# 5'
export LESS="-R"
#export MYSQL_PS1="[\R:\m:\s] (\U:\d)\nmysql> "

export MANPATH=/usr/local/git/share/man:$MANPATH

bindkey -e
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

##PROMPT='[%n@%m]%# '
##RPROMPT='[%~]'
#PROMPT="[%B%~${default}%b] %E
#%b%# "
##RPROMPT="[%n@%M]"

autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
RPROMPT="%1(v|%F{green}%1v%f|) [%n@%M]"

prompt_bar_left="[%B%~${default}%b] %E"
prompt_bar_right="(%D{%Y/%m/%d %H:%M:%S})"
prompt_left="%# "

count_prompt_characters()
{
    print -n -P -- "$1" | sed -e $'s/\e\[[0-9;]*m//g' | wc -m | sed -e 's/ //g'
}

update_prompt()
{
    local bar_left_length=$(count_prompt_characters "$prompt_bar_left")
    local bar_rest_length=$[COLUMNS - bar_left_length + 2]
    local bar_left="$prompt_bar_left"
    local bar_right_without_path="${prompt_bar_right}"
    local bar_right_without_path_length=$(count_prompt_characters "$bar_right_without_path")
    local max_path_length=$[bar_rest_length - bar_right_without_path_length]
    bar_right=${prompt_bar_right}
    local separator="${(l:${bar_rest_length}:: :)}"
    bar_right="%${bar_rest_length}<<${separator}${bar_right}%<<"
    PROMPT="${bar_left}${bar_right}"$'\n'"${prompt_left}"
}

precmd_functions=($precmd_functions update_prompt)

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

case "${OSTYPE}" in
darwin*)
    alias ls="ls -G"
    chpwd() { clear;echo \[`pwd`\];ls -hl -G }
    li () {
        ifconfig en0 | awk '/inet / { print $2 }'
        hostname
    }
;;
linux*)
    alias ls='ls --color'
    chpwd() { clear;echo \[`pwd`\];ls -hl --color=tty }
    li () {
        grep "release 6" /etc/redhat-release > /dev/null
        if [ $0 = 1 ]; then
            ifconfig |grep inet |grep -v '127.0.0.1'|cut -d ":" -f 2|cut -d " " -f 1; hostname
        else
            ip -f inet -o addr show eth0|cut -d\  -f 7 | cut -d/ -f 1
        fi
        hostname
    }
;;
esac

alias ag="ag --pager 'less -R'"
alias info="info --vi-keys"
alias l=clear
alias la='ls -A'
alias le=less
alias ll='ls -hl'
alias lla='ls -hlA'
alias lld='ls -hld'
alias m=more
#alias mysql="mysql --pager='less -S -# 5'"
alias ja="export LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja:en_GB:en"
alias en="export LANG=en_US.UTF-8 LANGUAGE=en_US:en:en_GB:en"
alias jman='LANG=ja_JP.UTF-8 LANGUAGE=ja_JP:ja:en_GB:en /usr/bin/man'
alias man='LANG=C man'
alias path='perl -MFile::Spec -le '"'"'print File::Spec->rel2abs($_) for @ARGV'"'"
alias perldoc='perldoc -t'
alias pv='perl -le '"'"'for $module (@ARGV) { eval "use $module"; print "$module ", ${"$module\::VERSION"} }'"'"
alias rb=ruby
alias sc=screen
alias sls="screen -ls"
alias sr="screen -r"
alias static_httpd='plackup -MPlack::App::Directory -e '"'"'Plack::App::Directory->new({root=>"."})->to_app'"'"
alias sx="screen -x"
alias w3m='w3m -no-mouse'
alias vi=vim
alias vie="vim -u ~/.vimrc_euc"
alias viewe="view -u ~/.vimrc_euc"
alias view="vim -R"
alias vii="vim -u ~/.vimrc_iso"
alias viewi="view -u ~/.vimrc_iso"
alias ymd="date +%Y%m%d"
alias hms='date +%H%M%S'
alias zmv='noglob zmv -W'
alias -g G='| grep'
alias -g H='| head'
alias -g L='| less'
alias -g S='| sort'
alias -g T='| tai64nlocal'
alias -g U='| uniq'
alias -g V='| grep -v'
alias -g W='| wc'
alias -g X='| xargs grep'

alias ga='git add'
alias gb='git br'
alias gl='git di'
alias gn='git remote -v'
alias gi='git ci'
alias go='git co'
alias gp='git push'
alias gt='git st'

#alias si='svn ci'
#alias so='svn co'
#alias st='svn st'
#alias up='svn up'

## screen auto run
#if [ $SHLVL = 1 ];then
#      screen -R
#fi

#functions
#go() {
#    if [ -e $1 ]; then
#        git checkout $1
#    else
#        /usr/bin/go $@
#    fi
#}
backup() { cp $1{,_`date +%Y%m%d%H%M%S`} }
ee () {
    uc=`echo $1 | tr "a-z" "A-Z"`
    eval echo \$$uc
}
gu () {
    branch=$1;
    if [ -z $branch ]; then
        branch="master";
    fi

    git pull origin $branch
}
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
optime() {
    cat /proc/uptime | awk '{print $1 / 60/60/24/365 " years / "$1 / 60/60/24 " days / "$1/60/60" hour / " $1 " sec"}'
} # or use uptime(only BSD?)
vm ()     { man $1 | col -b | vi -R - }
jvm ()   { jman $1 | col -b | vi -R - }
pm () { perldoc $1 | col -b | vi -R - }
vigrep () { vi `git grep -l $@` }
viewgrep () { view `git grep -l $@` }
viack() { vi `ack -l $@` }
vieack() { vim -u ~/.vimrc_euc `ack -l $@` }
viewack () { view `ack -l $@` }
viag() { vim `ag -l $@` }
uri_escape () {
    for i in $@
    do
        echo $i | perl -MURI::Escape -nle 'print uri_escape($_)'
    done
}
uri_unescape () {
    for i in $@
    do
        echo $i | perl -MURI::Escape -nle 'print uri_unescape($_)'
    done
}
split_param () {
    echo $1 | perl -MCGI -nle '
my ($base, $params) = split /\?/, $_;
print $base;

my $q = CGI->new($params);
for my $r ($q->param) {
    my $v = $q->param($r);
    print "$r => $v";
}
    '
}
epoch2ymdhms () {
    date +"%Y/%m/%d %H:%M:%S" -d @$1
}

line() {
    pipe=`cat -`
    message=`echo -e "$@\n$pipe"`
    echo -e "$message"
    curl -X POST -H "Authorization: Bearer $LINE_NOTIFY_SHELL_TOKEN" -F "message=$message" https://notify-api.line.me/api/notify 2>&1
}

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

PATH=~/bin:/sbin:/usr/sbin:/usr/local/bin:/var/lib/gems/1.8/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

load_if_exists "$HOME/perl5/perlbrew/etc/bashrc"
load_if_exists "$HOME/.zshrc_after"
load_if_exists "$HOME/.opt/autojump_v12/autojump.zsh"
load_if_exists "$HOME/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
