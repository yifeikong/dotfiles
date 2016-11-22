export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

nonzero_return() {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "$RETVAL"
}

parse_git_branch() { 
   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/' 
} 

export PS1="\[\e[1m\]\[\e[33m\]\`parse_git_branch\`\[\e[m\]\[\e[1m\]\u@\h \w \[\e[31m\]\`nonzero_return\`\[\e[m\]\\$ "
export THE_PS1=$PS1

export EDITOR='vim'
[ -z "$TMUX" ] && export TERM='xterm-256color'
alias vi=vim
alias v=vim
alias cd..='cd ..'
alias bpy=bpython
alias py=python
alias tmux='tmux -2'
alias g='git'
alias ll='ls -alh'
alias :q='exit'
alias :wq='exit'
alias get='apt-get'
alias mkdirp='mkdir -p'
alias hgrep='history | grep'
alias shn='sudo shutdown -h now'
alias mirror='wget -E -H -k -K -p'
alias prettyjson='python -m json.tool'
alias def='python3 ~/.dotfiles/def.py'
alias reload='source ~/.bashrc && echo ".bashrc reloaded"'
alias dc='docker-compose'
alias spaces='du -sh $(ls)'
alias sudo='sudo ' # magic trick to bring aliases to sudo
alias px="proxychains4"
alias dkr="docker"
alias lcurl='curl --noproxy localhost'
alias save-last-command='history | tail -n 2 | head -n 1 >> ~/.dotfiles/useful_commands'

=() {
    python3 -c "from math import *;print($*)"
} # simple calculator

gdiff() {
    diff -u $@ | colordiff | less -R;
}

proxy() {
    if [ $1 == "on" ]; then
        export http_proxy="http://127.0.0.1:8123"
        export https_proxy=$http_proxy
    else
        export http_proxy=""
        export https_proxy=$http_proxy
    fi
}


DEFAULT_VENV_NAME=".venv"
alias create-venv2="virtualenv $DEFAULT_VENV_NAME"
alias create-venv="python3 -m venv $DEFAULT_VENV_NAME"
alias activate="source $DEFAULT_VENV_NAME/bin/activate"

_virtualenv_auto_activate() {
    if [ -e ".venv" ]; then
        # Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/.venv" ]; then
            echo Activating virtualenv ...
            export VENV_ROOT=$PWD
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate
            export PS1="\[\e[1m\]\[\e[33m\][v]\[\e[m\]$THE_PS1"
        fi
    else
        if [ "${PWD##$VENV_ROOT}" == "${PWD}" ]; then
            # should check if parent exists .venv
            export PS1=$THE_PS1
            type deactivate &> /dev/null && deactivate
        fi
    fi
}

export PROMPT_COMMAND=_virtualenv_auto_activate

polipo socksParentProxy=localhost:1080 daemonise=true pidFile=$HOME/.polipo.pid logFile=/dev/null
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools

for f in $HOME/.dotfiles/completions/*.sh; do
    source "$f"
done

[[ -s ~/.dotfiles/local_bashrc ]] && source ~/.dotfiles/local_bashrc
