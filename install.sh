#!/bin/bash

if [ "${1}" == "full" ]; then
    # i3
    ln -s "$(pwd)"/i3 ~/.i3

    # fixes
    mkdir ~/bin
    ln -s $(pwd)/scripts/fixes/wakeup_fix.sh ~/bin/wakeup_fix.sh
fi

if [ "${1}" == "remove" ]; then
    rm ~/.i3
    rm ~/.tmux.conf
    rm ~/.zshrc
    rm ~/.zsh
    rm ~/.config/htop/htoprc
    rm ~/.local/share/nvim/site/autoload/plug.vim
    rm ~/.config/nvim/init.vim
    rm ~/.nvimrc
    rm ~/.vimrc
    rm ~/.vim/autoload/plug.vim
else
    # tmux
    ln -s "$(pwd)"/tmux.conf ~/.tmux.conf
    
    # zsh
    ln -s "$(pwd)"/zsh/zshrc ~/.zshrc
    ln -s "$(pwd)"/zsh ~/.zsh
    
    # htop
    mkdir ~/.config/htop
    ln -s $(pwd)/htoprc ~/.config/htop/htoprc
    
    # nvim
    mkdir -p ~/.config/nvim
    mkdir -p ~/.local/share/nvim/site/autoload/
    ln -s $(pwd)/nvim/plug.vim ~/.local/share/nvim/site/autoload/plug.vim
    ln -s $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
    ln -s $(pwd)/nvim/init.vim ~/.nvimrc
    
    # vim
    mkdir -p ~/.vim/autoload
    ln -s $(pwd)/nvim/init.vim ~/.vimrc
    ln -s $(pwd)/nvim/plug.vim ~/.vim/autoload/plug.vim
fi

