#/bin/bash

DOTFILES_DIR=$HOME/.dotfiles

# Linking
ln -s $DOTFILES_DIR/tmux.conf ~/.tmux.conf
ln -s $DOTFILES_DIR/agignore ~/.agignore
ln -s $DOTFILES_DIR/gitconfig ~/.gitconfig
echo "source $DOTFILES_DIR/bashrc" >> ~/.bashrc
mkdir ~/.fonts
cp ~/.dotfiles/monaco_powerline.otf ~/.fonts
echo "[[ -s ~/.bashrc ]] && source ~/.bashrc" >> ~/.bash_profile

# Vim, vimrc is inside dotfiles, but .vim files are outside
cd ~
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

ln -s $DOTFILES_DIR/vimrc $HOME/.vimrc # vimrc
mkdir -p $HOME/.vim/autoload
mkdir -p $HOME/.vim/undodir
ln -s $HOME/.vim $HOME/.config/nvim # for nvim
ln -s $DOTFILES_DIR/vimrc $HOME/.config/nvim/init.vim
vim +PlugInstall
