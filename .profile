umask 0022
unset MAILCHECK

set -o vi

export PATH=${HOME}/bin:${PATH}:/sbin:/usr/sbin:/usr/local/bin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin
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

# OS-specific stuff
case `uname` in
  SunOS)
    export PATH=${PATH}:/opt/csw/bin
    export TERM=xterm
esac

# Profile deployment
function profile-deploy() {
    /usr/bin/ssh "$@" "if [[ ! -e '.ssh' ]]; then mkdir .ssh; fi" ;
    /usr/bin/scp -r $HOME/.ssh/ "$@":. >/dev/null;
    /usr/bin/scp -r $HOME/.bashrc $HOME/.profile $HOME/.screenrc $HOME/.vim $HOME/.vimrc $HOME/bin/ "$@":. >/dev/null;
}

# Git repo uber-update
function update-repositories() {
    for i in $( find . -type d -maxdepth 1 ); do
        if [ -e $i/.git ]; then
            echo $'\E[01;35m'$i$'\E[00m';
            cd $i; git pull;
            cd - >/dev/null;
            echo;
        fi
    done
}

# Git tab-completion
if [ -e ~/bin/git/git-completion.sh ]; then
	source ~/bin/git/git-completion.sh
fi

# Highlighter grep
function highlight() {
    grep --color -E "$@|$"
}

# SSH tab-completion
if [ -e ~/.bash_history ]; then
    complete -W "$( echo $( grep '^ssh ' ~/.bash_history | sort -u | sed 's/^ssh //' ) )" ssh profile-deploy
fi

# ec2 Credentials
if [ -e ~/.ec2/.setup ]; then
    source ~/.ec2/.setup
fi

alias clear='clear ; echo'
alias ll='ls -al'
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
alias more=${READER} less=${READER}
alias rscp='rsync -av --delete --stats -e ssh'
alias ssh='ssh -AX'
alias sudo='A=`alias` sudo env PATH=$PATH'

export PS1='\[\e[32m\]\u\[\e[00m\] @\[\e[33m\]\h\[\e[00m\] :\[\e[36m\]\w$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo " \[\e[00m\]($(git branch | grep '^*' | sed s/\*\ //))"; fi)\[\e[00m\] \$ '

echo; echo Host: $( /bin/hostname )

