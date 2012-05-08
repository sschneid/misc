umask 0022
unset MAILCHECK

set -o vi

export PATH=${PATH}:/sbin:/usr/sbin:/usr/local/bin:${HOME}/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin
export MANPATH=/opt/local/share/man:$MANPATH
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export TERM=xterm-color
export COPYFILE_DISABLE=true

export ORIGIN=${SSH_CLIENT%% *}

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

function profile-deploy() {
    /usr/bin/ssh "$@" "if [[ ! -e '.ssh' ]]; then mkdir .ssh; fi" ;
    /usr/bin/scp ~sschneider/.ssh/authorized_keys "$@":.ssh/. >/dev/null;
    /usr/bin/scp -r ~sschneider/.bashrc ~sschneider/.profile ~sschneider/.screenrc ~sschneider/bin/ "$@":. >/dev/null;
}

function update-repositories() {
    for i in $( find . -type d -maxdepth 1 ); do
        if [ -e $i/.git ]; then
            echo $i;
            cd $i; git pull;
            cd - >/dev/null;
            echo;
        fi
    done
}

# Git tab-completion
source ~/bin/git/git-completion.sh

# SSH tab-completion
if [ -e .bash_history ]; then
    complete -W "$( echo $( grep '^ssh ' .bash_history | sort -u | sed 's/^ssh //' ) )" ssh profile-deploy
fi

alias more=${READER} less=${READER}
alias ssh='ssh -AX'
alias ll='ls -al'
alias sudo='A=`alias` sudo '
alias rscp='rsync -av --delete --stats -e ssh'

alias puppetrun='sudo puppet agent -o -v --no-daemonize'

alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

alias mc='ssh -Aqt sschneider@mail2.mercycorps.org ssh -Aqt'

export PS1='[\u@\h:\w$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "($(git branch | grep '^*' | sed s/\*\ //))"; fi)]\\$ '

echo; echo Host: $( /bin/hostname )

