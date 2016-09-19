#!/bin/bash

DOTFILES_DIR=$HOME/.dotfiles

install_tmux() {
    ln -sfv $DOTFILES_DIR/tmux.conf ~/.tmux.conf
}

install_ag() {
    ln -sfv $DOTFILES_DIR/agignore ~/.agignore
}

install_git() {
    ln -sfv $DOTFILES_DIR/gitconfig ~/.gitconfig
}

install_bashrc() {
    echo "[[ -s ~/.bashrc ]] && source ~/.bashrc" >> ~/.bash_profile
    echo "source $DOTFILES_DIR/bashrc" >> ~/.bashrc
}

install_fonts() {
    echo You need to manully install the font
}

install_vim() {
    # Vim, vimrc is inside dotfiles, but .vim files are outside
    cd ~
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    ln -sfv $DOTFILES_DIR/vimrc $HOME/.vimrc # vimrc
    mkdir -p $HOME/.vim/autoload
    mkdir -p $HOME/.vim/undodir
    ln -sfv $HOME/.vim $HOME/.config/nvim # for nvim
    ln -sfv $DOTFILES_DIR/vimrc $HOME/.config/nvim/init.vim
    vim +PlugInstall
    cd -
}

for prog in tmux ag git fonts bashrc vim; do
    if [ "$1" != "-y" ]; then
        echo -n "$(tput bold)install $prog config?[Y/n]$(tput sgr0) "
        read ok
        if [ "$ok" == 'n' ]; then
            continue
        fi
    fi
    echo "  => installing $prog config"
    install_$prog #call the install method
done


