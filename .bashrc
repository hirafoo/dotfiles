alias ..='cd ..'
alias l=clear
alias ls='ls --color'
alias ll='ls -l'

#WORKING_DIRECTORY='\[\e[$[COLUMNS-$(echo -n " (\w)" | wc -c)]C\e[1;35m(\w)\e[0m\e[$[COLUMNS]D\]'
#PS1=${WORKING_DIRECTORY}'${debian_chroot:+($debian_chroot)}\[\e[0;33m\][$(date +%H:%M:%S)#\#]\[\e[1;32m\]\u@\h\[\e[00m\]\$ '

WORKING_DIRECTORY='\[\e[$[COLUMNS-$(echo -n " [\u@\h]" | wc -c)]C\e[m[\u@\h]\e[\e[$[COLUMNS]D\]'
PS1="${WORKING_DIRECTORY}[\w]\n$ "
function cd () {
    l
    builtin cd $1
    echo [`pwd`]
    ll
}
