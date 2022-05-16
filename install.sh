#!/bin/bash

BLUE="\033[1;34m"
NC="\033[0m"

REP="$HOME/dotfiles"
FILES=(
    "config/alacritty"
    "config/awesome"
    "config/conky"
    "config/dunst"
    "config/fish"
    "config/nvim/init.lua"
    "config/nvim/lua"
    "config/picom"
    "config/qtile"
    "config/polybar"
    "config/wezterm"
    "config/bspwm"
    "config/sxhkd"
    "config/rofi"
    "config/openbox"
    "Xresources.d"
    "Xresources"
    "tmux.conf"
    "zshrc"
    "scripts"
)

for f in ${FILES[@]}; do
    hf=".$f"
    echo -e "Installing ${BLUE}$hf${NC} file ..."
    if [[ -e "$HOME/$hf" ]]; then
        if [[ -L "$HOME/$hf" && $(readlink -f "$HOME/$hf") = "$REP/$f" ]]; then
            echo -e "  The file ${BLUE}$HOME/$hf${NC} has already been installed. \u2714"
            continue
        else
            echo -e "  Existing file, backing up ${BLUE}$hf${NC} \uf071"
            mv "$HOME/$hf" "$HOME/$hf.bak"
        fi
    fi
    echo -e "  Creating the file ${BLUE}$HOME/$hf${NC} linking to ${BLUE}$REP/$f${NC}"
    mkdir -p $(dirname $HOME/$hf)
    ln -s "$REP/$f" "$HOME/$hf"
    echo -e "  Done! \u2714"
done
