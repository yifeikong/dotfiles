
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

export EDITOR='vim'
[ -z "$TMUX" ] && export TERM='xterm-256color'
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
alias def='python ~/.dotfiles/def.py'
alias reload='source ~/.bashrc && echo ".bashrc reloaded"'
alias dc='docker-compose'
alias spaces='du -sh $(ls)'
alias sudo='sudo ' # magic trick to bring aliases to sudo
alias px="proxychains4"
alias docker-init='eval "$(docker-machine env default)"'
alias lcurl='curl --noproxy localhost'

=() {
    python3 -c "from math import *;print($*)"
} # simple calculator

gdiff() {
    diff -u $@ | colordiff | less -R;
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
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate
            _OLD_VIRTUAL_PS1="$PS1"
            PS1="\[$(tput setaf 6)\]\[$(tput bold)\][v]\[$(tput sgr0)\]$PS1"
            export PS1
        fi
    fi
}

export PROMPT_COMMAND=_virtualenv_auto_activate

[[ -s ~/.dotfiles/local_bashrc ]] && source ~/.dotfiles/local_bashrc
