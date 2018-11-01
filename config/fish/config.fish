# Custom PATH
set -gx PATH $HOME/.local/bin $HOME/.script $HOME/go/bin $HOME/.config/composer/vendor/bin $PATH

# done plugin: Define a delay for trigger
set -U __done_min_cmd_duration 5000

# Colors
set fish_color_search_match --background='blue'

# less pager for man pages
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
export LESS="-R "
export LGOPATH="$HOME/go/bin"

# bspwm sxhkd
export SXHKD_SHELL=sh

# virtualenv with virtualfish
eval (python -m virtualfish)

# Aliases
alias cdd="cd $HOME/Desktop"
alias say="trans -speak"
