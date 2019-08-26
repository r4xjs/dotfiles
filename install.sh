#!/bin/bash

if [ "${1}" == "full" ]; then
    # i3
    ln -s "$(pwd)"/i3 ~/.i3

    # fixes
    mkdir ~/bin
    ln -s $(pwd)/scripts/fixes/wakeup_fix.sh ~/bin/wakeup_fix.sh
    ln -s $(pwd)/scripts/fixes/brightness.sh ~/bin/brightness.sh
   
    # bluetooth pulseaudio default setup
    read -p "Do you want to setup bluetooth headphone to pulse/default.pa?" yn
    if [ "$yn"  = "y" ]; then
        echo "set-default-sink bluez_sink.04_5D_4B_DE_25_67.headset_head_unit" >> /etc/pulse/default.pa
        echo "set bluez_sink.04_5D_4B_DE_25_67.headset_head_unit as default"
    fi
fi

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
