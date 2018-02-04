# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="amuse"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
plugins=(brew common-aliasesgit debian django pylint python tmux)

export PYTHONPATH=$PYTHONPATH:$HOME/repos/futile:$HOME/repos

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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


export EDITOR='vim'
[ -z "$TMUX" ] && export TERM='xterm-256color'
if type nvim &> /dev/null; then
    alias vi=nvim
    alias v=nvim
    alias vim=nvim
else
    alias vi=vim
    alias v=vim
fi
alias t='tmux -2'
alias ta='tmux -2 a'
alias cd..='cd ..'
alias ipy=ipython
alias py=python
alias tmux='tmux -2'
alias g='git'
alias ll='ls -alh'
alias :q='exit'
alias :wq='exit'
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
alias nv='nvim'
alias aj='autojump'
alias canary="/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary"


add_path_if_not_exists() {
    # this is really some voodoo
    path_to_add=$1
    var_to_change=$2
    [[ ":${!var_to_change}:" != *":$path_to_add:"* ]] && export $var_to_change="$path_to_add:${!var_to_change}"
}


add_path_if_not_exists $HOME/.local/bin "PATH"
add_path_if_not_exists $HOME/.cargo/bin "PATH"
if uname | grep -q Darwin; then
    polipo socksParentProxy=localhost:1080 daemonise=true pidFile=$HOME/.polipo.pid logFile=/dev/null
    export ANDROID_HOME=$HOME/Library/Android/sdk
    add_path_if_not_exists $ANDROID_HOME/tools "PATH"
    add_path_if_not_exists $ANDROID_HOME/platform-tools "PATH"
fi

for f in $HOME/.dotfiles/completions/*.sh; do
    source "$f"
done


export PYTHONPATH=$HOME/repos/futile:$HOME/repos:$PTYHONPATH
export GOPATH=$HOME/repos

[[ -s ~/.dotfiles/local_zshrc ]] && source ~/.dotfiles/local_zshrc
