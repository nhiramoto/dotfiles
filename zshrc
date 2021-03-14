# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export LANG="en_US.UTF-8"

zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

#POWERLEVEL9K_MODE='nerdfont-complete'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="tjkirch_mod2"
ZSH_THEME="powerlevel10k/powerlevel10k"

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv anaconda pyenv rbenv root_indicator)
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status vcs)
#POWERLEVEL9K_DIR_SHOW_WRITABLE=true
DEFAULT_USER="$USER"
#POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
#POWERLEVEL9K_SHORTEN_DELIMITER=""
#POWERLEVEL9K_SHORTEN_STRATEGY="truncate_with_package_name"
#POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
#POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$''
#POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$''

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# bgnotify
bgnotify_threshold=4
function bgnotify_formatted {
  ## $1=exit_status, $2=command, $3=elapsed_time
  [ $1 -eq 0 ] && title="Command Done!" || title="Command Failed!"
  bgnotify "$title" "<b>Command</b>: \"$2\"\n<b>Elapsed</b>: $3 s"
}

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    bgnotify
    zsh-syntax-highlighting
    themes
    zsh-256color
    zsh-autopair
    #zsh-autosuggestions
)

# Check cached .zcompdump once a day
# https://gist.github.com/ctechols/ca1035271ad134841284
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit;
else
    compinit -C;
fi;
# autoload -U compinit && compinit

# User configuration

export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/apache-maven-3.3.9/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="rxvt-unicode-256color"

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="$editor ~/.zshrc"
# alias ohmyzsh="$editor ~/.oh-my-zsh"

# Config Files
alias __tmux="$EDITOR $HOME/.tmux.conf"
alias __vim="$EDITOR $HOME/.config/nvim/init.vim"
alias __emacs="$EDITOR $HOME/.emacs.d/custom.org"
alias __zsh="$EDITOR $HOME/.zshrc"
alias __xres="$EDITOR $HOME/.Xresources"
alias __termite="$EDITOR $HOME/.config/termite/config"
alias __urxvt="$EDITOR $HOME/.Xresources.d/rxvt-unicode"
alias __rofi="$EDITOR $HOME/.Xresources.d/rofi"
alias __i3="$EDITOR $HOME/.config/i3/config"
alias __polybar="$EDITOR $HOME/.config/polybar/config"
alias __bsp="$EDITOR $HOME/.config/bspwm/bspwmrc"
alias __sxhkd="$EDITOR $HOME/.config/sxhkd/sxhkdrc"
alias __xmonad="$EDITOR $HOME/.xmonad/xmonad.hs"
alias __xmobar="$EDITOR $HOME/.xmonad/xmobar/xmobarrc"
alias __awesome="$EDITOR $HOME/.config/awesome/rc.lua"
alias __tsm="$EDITOR $HOME/.config/transmission-daemon/settings.json"
alias __openbox="$EDITOR $HOME/.config/openbox/rc.xml"
alias __openboxmenu="$EDITOR $HOME/.config/openbox/menu.xml"
alias __openboxenv="$EDITOR $HOME/.config/openbox/environment"
alias __openboxauto="$EDITOR $HOME/.config/openbox/autostart"

alias open=xdg-open
alias pacsize="expac -S -H M '%k/t%n'"
alias now="date +'%H:%M:%S'"
alias today="date +'%A %d de %B de %Y'"
alias up="cd .."
alias fe="nautilus ."
alias edit="$EDITOR"
alias tasks="ps -ef | grep -i"
alias install="pacman -S"
alias search="pacman -Ss"
alias cdd="cd ~/Desktop"
alias news="newsboat"
alias tsm="transmission-remote"
alias tsmd="transmission-daemon"
alias tsmc='tremc'
alias yt='youtube-dl'
alias ls="exa"
alias la="exa -la"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"

PATH="$HOME/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
export GEM_HOME=$HOME/.gem

# Set up Node Version Manager
export NVM_DIR="$HOME/.nvm"                            # You can change this if you want.
export NVM_SOURCE="/usr/share/nvm"                     # The AUR package installs it to here.
[ -s "$NVM_SOURCE/nvm.sh" ] && . "$NVM_SOURCE/nvm.sh"  # Load NVM

# Termite current directory
# if [[ $TERM == xterm-termite ]]; then
#   . /etc/profile.d/vte.sh
#   __vte_osc7
# fi

# Disable bracketed paste mode for terminals that
#   doesn't support escape sequences (like Emacs shell)
if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# Use most as pager
# export PAGER="most"

# Default Terminal
export TERMINAL="urxvt"

# Python Virtualenv
export WORKON_HOME=$HOME/.virtualenvs
#source /usr/bin/virtualenvwrapper_lazy.sh

# Zsh Line Editor: Enable vi mode
#bindkey -v

# fzf
#source /usr/share/fzf/key-bindings.zsh
#source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

function sd () {
    wget -r -nc -p --html-extension -k -D $2 -np $1
}

function chpwd_lsla () {
    emulate -L zsh
    if [[ "$PWD" != "$HOME" ]]; then
        ls -la
    fi
}
chpwd_functions=(${chpwd_functions[@]} "chpwd_lsla")

# Colored Pager
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# Colored Man Pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Color Scripts (https://gitlab.com/dwt1/shell-color-scripts)
#colorscript random
