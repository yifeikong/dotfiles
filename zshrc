# From: https://github.com/skywind3000/vim/blob/master/etc/zshrc.zsh
ANTIGEN="$HOME/.local/bin/antigen.zsh"
PATH="$PATH"
DISABLE_FZF_AUTO_COMPLETION=true

# Install antigen.zsh if not exist
if [ ! -f "$ANTIGEN" ]; then
    echo "Installing antigen ..."
    [ ! -d "$HOME/.local" ] && mkdir -p "$HOME/.local" 2> /dev/null
    [ ! -d "$HOME/.local/bin" ] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    [ ! -f "$HOME/.z" ] && touch "$HOME/.z"
    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"
    if [ -x "$(which curl)" ]; then
        curl -L "$URL" -o "$TMPFILE"
    elif [ -x "$(which wget)" ]; then
        wget "$URL" -O "$TMPFILE"
    else
        echo "ERROR: please install curl or wget before installation !!"
        exit
    fi
    if [ ! $? -eq 0 ]; then
        echo ""
        echo "ERROR: downloading antigen.zsh ($URL) failed !!"
        exit
    fi;
    echo "move $TMPFILE to $ANTIGEN"
    mv "$TMPFILE" "$ANTIGEN"
fi


# Initialize command prompt
export PS1="%n@%m:%~%# "

# Enable 256 color to make auto-suggestions look nice
export TERM="xterm-256color"

# exit for non-interactive shell
[[ $- != *i* ]] && return

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# Initialize antigen
source "$ANTIGEN"

# using oh-my-zsh plugins for antigen
antigen use oh-my-zsh

# default bundles
# visit https://github.com/unixorn/awesome-zsh-plugins
# antigen bundle sudo
antigen bundle thefuck
# antigen bundle vi-mode
antigen bundle tmux
antigen bundle ansible
antigen bundle git
antigen bundle pip
antigen bundle command-not-find
antigen bundle colored-man-pages
antigen bundle django
antigen bundle docker
antigen bundle fzf
antigen bundle history
antigen bundle kubectl
antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle rupa/z z.sh
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
# antigen bundle supercrabtree/k
antigen bundle Vifon/deer
antigen bundle nojhan/liquidprompt
antigen bundle willghatch/zsh-cdr
antigen bundle zsh-users/zaw
antigen bundle wfxr/forgit

antigen theme candy


# check login shell
if [[ -o login ]]; then
    [ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
    [ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
fi

# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

# enable syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply



# options
unsetopt correct_all

setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Dont write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY # Dont execute immediately upon history expansion.
setopt promptsubst


# ignore complition
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
zstyle ':completion:*:*sh:*:' tag-order files


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.dotfiles/fzf.conf ] && source ~/.dotfiles/fzf.conf


DEFAULT_VENV_NAME=".venv"
alias create-venv2="virtualenv $DEFAULT_VENV_NAME"
alias create-venv="python3 -m venv $DEFAULT_VENV_NAME"
alias activate="source $DEFAULT_VENV_NAME/bin/activate"
export THE_PS1=$PS1
_virtualenv_auto_activate() {
    if [ -e ".venv" ]; then
        # Check to see if already activated to avoid redundant activating
        if [ "$VIRTUAL_ENV" != "$(pwd -P)/.venv" ]; then
            export VENV_ROOT=$PWD
            VIRTUAL_ENV_DISABLE_PROMPT=1
            source .venv/bin/activate
            export PS1="[v]$THE_PS1"
        fi
    else
        if [ "${PWD##$VENV_ROOT}" = "${PWD}" ]; then
            # should check if parent exists .venv
            export PS1=$THE_PS1
            type deactivate &> /dev/null && deactivate
        fi
    fi
}

precmd_functions=(_virtualenv_auto_activate)


function gtree {
    git_ignore_files=("$(git config --get core.excludesfile)" .gitignore ~/.gitignore)
    ignore_pattern="$(grep -hvE '^$|^#' "${git_ignore_files[@]}" 2>/dev/null|sed 's:/$::'|tr '\n' '\|')"
    if git status &> /dev/null && [[ -n "${ignore_pattern}" ]]; then
      tree -I "${ignore_pattern}" "${@}"
    else
      tree "${@}"
    fi
}


export EDITOR='vim'
[ -z "$TMUX" ] && export TERM='xterm-256color'
if type nvim &> /dev/null; then
    alias v=nvim
    alias vi=nvim
    alias vim=nvim
    alias nv=nvim
else
    alias v=vim
    alias vi=vim
fi
alias fig=docker-compose
alias tmux='tmux -2'
alias t='tmux -2'
alias cd..='cd ..'
alias ipy=ipython
alias py=python
alias g='git'
alias ll='ls -alh'
alias :q='exit'
alias :wq='exit'
alias mkdirp='mkdir -p'
alias shn='sudo shutdown -h now'
alias mirror='wget -E -H -k -K -p'
alias reload='source ~/.zshrc && echo ".zshrc reloaded"'
alias dc='docker-compose'
alias sudo='sudo ' # magic trick to bring aliases to sudo
alias px="proxychains4"
alias lcurl='curl --noproxy localhost'
alias save-last-command='history | tail -n 2 | head -n 1 >> ~/.dotfiles/useful_commands'
alias topcpu='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head'
alias topmem='ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head'

function proxy {
    if [[ $1 = "on" ]]; then
        # proxy offered by local shadowsocks
        export http_proxy=http://127.0.0.1:1087
        export https_proxy=http://127.0.0.1:1087
    elif [[ $1 = "off" ]]; then
        unset http_proxy
        unset https_proxy
    else
        echo -n "Usage: proxy [on|off] "
    fi
    echo http_proxy=$http_proxy https_proxy=$https_proxy
}

export HOMEBREW_NO_AUTO_UPDATE=1

typeset -U path
path+=($HOME/.local/bin)
path+=($HOME/.cargo/bin)
path+=(/usr/local/go/bin)
path+=($HOME/.dotfiles/bin)
path+=($HOME/.linuxbrew/bin)
path+=($HOME/repos/deploy/bin)
path+=(/snap/bin)
if uname | grep -q Darwin; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    path+=($ANDROID_HOME/tools)
    path+=($ANDROID_HOME/platform-tools)
    # proxy on
fi

export UNITYPATH=$HOME/repos/unity
export PYTHONPATH=$UNITYPATH/py/src:$HOME:/repo:$HOME/repos/futile:$HOME/repos:/var/compiled
export CONFPATH=$HOME/repos/conf
export GOPATH=$UNITYPATH/go
path+=($GOPATH/bin)
path+=(/home/linuxbrew/.linuxbrew/bin)

[[ -s ~/.dotfiles/local_zshrc ]] && source ~/.dotfiles/local_zshrc

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U +X bashcompinit && bashcompinit

eval $(thefuck --alias)
# bindkey -e
