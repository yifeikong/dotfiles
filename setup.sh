#!/bin/bash

DOTFILES_DIR=$HOME/.dotfiles

install_node() {
    # node tags support
    npm install --global git+https://github.com/Perlence/tstags.git 
}

install_tmux() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew install cmatrix
    else
        sudo apt install -y cmatrix
    fi
    mkdir $HOME/.tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ln -sfv $DOTFILES_DIR/tmux.conf ~/.tmux.conf
    # git clone https://github.com/tmux-plugins/tmux-resurrect tmux-resurrect
}

install_git() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        sudo apt install -y git
    else
        brew install git
    fi
    sudo curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o /usr/local/bin/diff-so-fancy
    sudo chmod +x /usr/local/bin/diff-so-fancy
    ln -sfv $DOTFILES_DIR/gitconfig ~/.gitconfig
}

install_bashrc() {
    echo "[[ -s ~/.bashrc ]] && source ~/.bashrc" >> ~/.bash_profile
    echo "source $DOTFILES_DIR/bashrc" >> ~/.bashrc
}

install_fonts() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew tap caskroom/fonts
        brew cask install font-fira-code
        echo "You need to set up fira code in iterm2"
    else
        echo "You need to install the fonts on client, skip"
    fi
}

install_zsh() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew install zsh
    else
        sudo apt install -y zsh
    fi
    sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
    chsh -s /bin/zsh
    ln -sfv $DOTFILES_DIR/zshrc ~/.zshrc
}

install_fuzzy_search() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew install the_silver_searcher fd
    else
        sudo apt install -y silversearcher-ag
        curl -L -O https://github.com/sharkdp/fd/releases/download/v7.2.0/fd-musl_7.2.0_amd64.deb
        dpkg -i fd-musl_7.2.0_amd64.deb
    fi
    ln -sfv $DOTFILES_DIR/agignore ~/.agignore
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

install_python() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew install python
    else
        sudo apt install -y python3-pip
    fi
    ln -sfv $DOTFILES_DIR/pycodestyle ~/.config/pycodestyle
    ln -sfv $DOTFILES_DIR/flake8 ~/.config/flake8
    ln -sfv $DOTFILES_DIR/pdbrc $HOME/.pdbrc
    ln -sfv $DOTFILES_DIR/pylintrc $HOME/.pylintrc
    pip3 install black jinja2 pyyaml mycli python-language-server rope \
        pycodestyle pydocstyle mccabe pyls-isort pyls-black pyls-mypy thefuck \
        pylint flake8 isort
}

install_vim() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew install vim ctags
    else
        # vim on ubuntu 18.04 is already 8.0
        sudo apt-get install exuberant-ctags -y
    fi
    pip3 install neovim
    # vimrc is inside dotfiles, but .vim files are outside
    ln -sfv $DOTFILES_DIR/vimrc $HOME/.vimrc # vimrc
    mkdir -p $HOME/.vim/autoload
    mkdir -p $HOME/.vim/undodir
    mkdir -p $HOME/.config
    ln -sfv $HOME/.vim $HOME/.config/nvim # for nvim
    ln -sfv $DOTFILES_DIR/vimrc $HOME/.config/nvim/init.vim
    rm -rf $HOME/.vim/UltiSnips
    ln -sfv $DOTFILES_DIR/vim/UltiSnips ~/.vim/UltiSnips
    vim +PlugInstall
}

install_ssh() {
    if [[ `uname -a` == *"Darwin"* ]]; then
        brew install mosh
    else
        sudo apt -y install mosh
    fi
    cat $DOTFILES_DIR/ssh_config >> $HOME/.ssh/config
}


if [ ! -z $1 ] && [ "$1" != "-y" ]; then
    prog=$1
    echo -en "\033[31minstall $prog config?\033[0m [Y/n] "
    echo "  => installing $prog config"
    install_$prog  # call the install method
    exit 0
else
    for prog in zsh tmux fuzzy_search git fonts bashrc vim ssh python; do
        if [ "$1" != "-y" ]; then
            echo -en "\033[31minstall $prog config?\033[0m [Y/n] "
            read ok
            if [ "$ok" == 'n' ]; then
                continue
            fi
        fi
        echo "  => installing $prog config"
        install_$prog #call the install method
    done
fi
