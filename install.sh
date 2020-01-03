#!/bin/bash

if [ "${1}" == "full" ]; then
    # i3
    ln -s "$(pwd)"/i3 ~/.i3

    # fixes
    mkdir ~/bin
    ln -s $(pwd)/scripts/fixes/wakeup_fix.sh ~/bin/wakeup_fix.sh
    
    # urxvt setup
    ln -s $(pwd)/scripts/local-open ~/bin/local-open
    ln -S $(pwd)/Xresources ~/.Xresources
    urxvt_perl_ext_path=$(locate "urxvt/perl/clipboard" | head -n 1 | sed 's/\/clipboard.*//g')
    if [[ ! -e "$urxvt_perl_ext_path" ]]; then
        ln -s $(pwd)/urxvt/clipboard "${urxvt_perl_ext_path}/clipboard"
    fi

    # zap hdpi fix
    mkdir "$HOME/.ZAP"
    ln -s $(pwd)/zap_jvm.properties "$HOME/.ZAP/.ZAP_JVM.properties"
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
    rm ~/.Xresources
    rm ~/bin/local-open
    rm ~/bin/wakeup_fix.sh
    rm ~/.scr
    rm ~/.ZAP/.ZAP_JVM.properties

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

    # scripts
    ln -s $(pwd)/scripts ~/.scr

    # irssi
    ln -s $(pwd)/irssi ~/.irssi
fi

