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

install_flake8() {
    ln -sfv $DOTFILES_DIR/flake8 ~/.config/flake8
}

install_vim() {
    apt-get install exuberant-ctags
    # Vim, vimrc is inside dotfiles, but .vim files are outside
    sudo apt-get install exuberant-ctags -y
    mkdir -p $HOME/.vim
    if [ ! -e $HOME/.vim/autoload/plug.vim ]; then
        curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi
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
    cat $DOTFILES_DIR/ssh_config >> $HOME/.ssh/config
}

install_completions() {
    bash $DOTFILES_DIR/install_completions.sh
}

for prog in z tmux ag git fonts bashrc vim ssh completions flake8; do
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


