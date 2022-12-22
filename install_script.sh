#!/usr/bin/env sh

shell="zsh"
aur_manager="paru"
rc=$(echo $shell'rc')
dir=$(pwd)


# Assumes sudo is configured
inst_package_man() {
    sudo pacman -Syu
    sudo pacman -S --needed base-devel

    git clone https://aur.archlinux.org/$aur_manager.git
    cd $aur_manager
    makepkg -si
}

inst_config_files() {
    if ( $dir != $HOME)
    then
        cp * $HOME
        rm $HOME/install_script.sh
    fi
}

inst_shell() {
    sudo pacman -S $shell

    chsh -s $(which $shell)
    source ~/.$rc
    if($shell == 'zsh')
    then
        sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
}


# Install doomemacs & dependencies

inst_doom() {
    sudo pacman -S ripgrep fd emacs

    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.emacs.d
    ~/.emacs.d/bin/doom install
}
