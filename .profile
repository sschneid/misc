umask 0022
unset MAILCHECK

set -o vi

export PATH=${PATH}:/sbin:/usr/sbin:/usr/local/bin:${HOME}/bin
export CVS_RSH='/usr/bin/ssh'
export CVSROOT=${LOGNAME}@cvs:/cvsroot

if [ -f /usr/bin/vim ]; then alias vi='vim'; fi

if [ -f /usr/bin/less ]; then
    READER='less -s -r'

    export LESS_TERMCAP_mb=$'\E[01;31m'
    export LESS_TERMCAP_md=$'\E[01;31m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;44;33m'
    export LESS_TERMCAP_ue=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[01;32m'
else
    READER='more'
fi

alias more=${READER} less=${READER}
alias ssh='ssh -X'
alias ll='ls -al'

if [ -f ~/bin/c-df ]; then
    if [ `/bin/uname` == 'AIX' ]; then
        alias df="~/bin/c-df -P"
    else
        alias df="~/bin/c-df"
    fi
fi

if [ `/bin/uname` == 'AIX' ]; then
    export PS1="[`echo $LOGNAME`@`/bin/hostname`:"'$PWD'"]\\$ "
else
    export PS1='[\u@\h:\w]\\$ '
fi

echo; echo Host: $(/bin/hostname)

