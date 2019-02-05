#!/bin/bash

BLUE="\033[1;34m"
NC="\033[0m"

REP="$HOME/dotfiles"
FILES=(zshrc vimrc Xresources tmux.conf "Xresources.d/rofi" "Xresources.d/rxvt-unicode" "Xresources.d/xterm")

for f in ${FILES[@]}; do
    hf=".$f"
    echo -e "Installing ${BLUE}$hf${NC} file ..."
    if [[ -f "$HOME/$hf" ]]; then
        if [[ -L "$HOME/$hf" && $(readlink -f "$HOME/$hf") = "$REP/$f" ]]; then
            echo -e "  The file ${BLUE}$HOME/$hf${NC} has already been installed."
            continue
        else
            echo -e "  Existing file, backing up ${BLUE}$hf${NC} ..."
            mv "$HOME/$hf" "$HOME/$hf.bak"
        fi
    fi
    echo -e "  Creating the file ${BLUE}$HOME/$hf${NC} linking to ${BLUE}$REP/$f${NC}"
    mkdir -p $(dirname $HOME/$hf)
    ln -s "$REP/$f" "$HOME/$hf"
done