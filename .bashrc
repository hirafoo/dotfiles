if [ -e ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

alias ..='cd ..'
alias l=clear
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

L1='\[\e[$[COLUMNS-$(echo -n " [\u@\H]" | wc -c)]C\e[m[\u@\H]\e[\e[$[COLUMNS]D\]'
PS1="${L1}[\w]\n$ "

function cd () {
    l
    builtin cd $1
    echo [`pwd`]
    ll
}


function share_history {
    history -a
    history -c
    history -r
}

PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=500
