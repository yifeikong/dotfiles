#!/bin/bash

DOTFILES_DIR=$HOME/.dotfiles

install_tmux() {
    sudo apt install -y cmatrix
    ln -sfv $DOTFILES_DIR/tmux.conf ~/.tmux.conf
    git clone https://github.com/tmux-plugins/tmux-resurrect tmux-resurrect
}

install_git() {
    sudo apt install -y git
    sudo curl https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -o /usr/local/bin/diff-so-fancy
    sudo chmod +x /usr/local/bin/diff-so-fancy
    ln -sfv $DOTFILES_DIR/gitconfig ~/.gitconfig
}

install_bashrc() {
    echo "[[ -s ~/.bashrc ]] && source ~/.bashrc" >> ~/.bash_profile
    echo "source $DOTFILES_DIR/bashrc" >> ~/.bashrc
}

install_fonts() {
    echo You need to manully install the font
}

install_zsh() {
    apt install -y zsh
    sudo sed s/required/sufficient/g -i /etc/pam.d/chsh
    chsh -s /bin/zsh
    ln -sfv $DOTFILES_DIR/zshrc ~/.zshrc
}

install_ag() {
    sudo apt install -y silversearcher-ag
    curl -L -O https://github.com/sharkdp/fd/releases/download/v7.2.0/fd-musl_7.2.0_amd64.deb
    dpkg -i fd-musl_7.2.0_amd64.deb
    ln -sfv $DOTFILES_DIR/agignore ~/.agignore
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}


install_vim() {
    sudo apt-get install exuberant-ctags python3-pip -y
    pip3 install neovim black
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
    sudo apt -y install mosh
    cat $DOTFILES_DIR/ssh_config >> $HOME/.ssh/config
}

install_completions() {
    bash $DOTFILES_DIR/install_completions.sh
}

install_python() {
    ln -sfv $DOTFILES_DIR/pycodestyle ~/.config/pycodestyle
    ln -sfv $DOTFILES_DIR/flake8 ~/.config/flake8
    ln -s $HOME/.dotfiles/pdbrc $HOME/.pdbrc
    ln -s $HOME/.dotfiles/pylintrc $HOME/.pylintrc
    pip3 insatll black jinja2 pyyaml mycli python-language-server rope pycodestyle pydocstyle mccabe pyls-isort pyls-black pyls-mypy thefuck
}


for prog in zsh tmux ag git fonts bashrc vim ssh completions python; do
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
