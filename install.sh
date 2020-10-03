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

    # xmodmap
    ln -s $(pwd)/xmodmap ~/.xmodmap

    # alacritty terminal
    mkdir "$HOME/.config/alacritty"
    ln -s "$(pwd)/alacritty.yml"  "$HOME/.config/alacritty/alacritty.yml"

fi

if [ "${1}" == "remove" ]; then
    rm ~/.i3
    rm ~/.tmux.conf
    rm ~/.zshrc
    rm ~/.zsh
    rm ~/.local/share/nvim/site/autoload/plug.vim
    rm ~/.config/nvim/init.vim
    rm -rf ~/.config/alacritty
    rm ~/.nvimrc
    rm ~/.vimrc
    rm ~/.vim/autoload/plug.vim
    rm ~/.Xresources
    rm ~/bin/local-open
    rm ~/bin/wakeup_fix.sh
    rm ~/.scr
    rm ~/.ZAP/.ZAP_JVM.properties
    rm ~/.config/lf/lfrc
    rm ~/.xmodmap
    rm ~/.doom.d/{config.el,init.el,packages.el}
else
    # tmux
    ln -s "$(pwd)"/tmux.conf ~/.tmux.conf
    
    # zsh
    ln -s "$(pwd)"/zsh/zshrc ~/.zshrc
    ln -s "$(pwd)"/zsh ~/.zsh
    
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

    # lf
    ln -s $(pwd)/lfrc ~/.config/lf/lfrc

    # doom emacs
    [ ! -d ~/.doom.d ] && mkdir ~/.doom.d 
    for conf in config.el init.el packages.el; do
        ln -s $(pwd)/doom/"$conf" ~/.doom.d/"$conf"
    done

fi

