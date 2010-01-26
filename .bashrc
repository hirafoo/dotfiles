if [ -e ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi

alias ..='cd ..'
alias l=clear
alias ls='ls --color -G'
alias ll='ls -l'

L1='\[\e[$[COLUMNS-$(echo -n " [\u@\H]" | wc -c)]C\e[m[\u@\H]\e[\e[$[COLUMNS]D\]'
PS1="${L1}[\w]\n$ "

function cd () {
    l
    builtin cd $1
    echo [`pwd`]
    ll
}
