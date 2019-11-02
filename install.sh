#!/bin/bash

if [ "${1}" == "full" ]; then
    # i3
    ln -s "$(pwd)"/i3 ~/.i3

    # fixes
    mkdir ~/bin
    ln -s $(pwd)/scripts/fixes/wakeup_fix.sh ~/bin/wakeup_fix.sh
    ln -s $(pwd)/scripts/fixes/brightness.sh ~/bin/brightness.sh
fi

if [ "${1}" == "remove" ]; then
    rm ~/.i3
    rm ~/bin/wakeup_fix.sh
    rm ~/bin/brightness.sh
    rm ~/.tmux.conf
    rm ~/.zshrc
    rm ~/.zsh/cache
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
    ln -s "$(pwd)"/zshrc ~/.zshrc
    mkdir -p ~/.zsh/cache
    
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

