# Path to your oh-my-zsh installation.
export ZSH=/home/segfault/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tjkirch_mod2"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# bgnotify
bgnotify_threshold=4
function bgnotify_formatted {
  ## $1=exit_status, $2=command, $3=elapsed_time
  [ $1 -eq 0 ] && title="Done!" || title="Failed!"
  bgnotify "$title" "<b>Command</b>: \"$2\"\n<b>Elapsed</b>: $3"
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
# plugins=(git zsh-syntax-highlighting themes zsh-256color zsh-output-highlighting zsh-autopair zsh-autosuggestions command-not-found)
plugins=(git bgnotify zsh-syntax-highlighting themes zsh-256color zsh-output-highlighting zsh-autopair)
autoload -U compinit && compinit

# User configuration

export PATH="/home/segfault/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"
export PATH="/opt/apache-maven-3.3.9/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG\='en_US.UTF-8'
export LC_ALL\="en_US.UTF-8"
export TERM\=xterm-256color

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='emacsclient -c --alternate-editor=""'

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
alias open=xdg-open
alias cvim="$EDITOR ~/.vimrc"
alias czsh="$EDITOR ~/.zshrc"
alias cterm="$EDITOR ~/.config/termite/config"
alias ci3="$EDITOR ~/.config/i3/config"
alias cpol="$EDITOR ~/.config/polybar/config"
alias cfgemacs="$EDITOR ~/.emacs.d/custom.org"
alias pacsize="expac -S -H M '%k/t%n'"
alias now="date +'%H:%M:%S'"
alias today="date +'%A %d de %B de %Y'"
alias up="cd .."
alias fe="nautilus ."
alias edit="$EDITOR"
alias tasks="ps -ef | grep -i"
alias install="pacman -S"
alias search="pacman -Ss"
alias cdd='cd ~/Desktop'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

# disable ctrl+s
stty -ixon -ixoff

DISABLE_AUTO_TITLE=true

PATH="/home/segfault/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/segfault/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/segfault/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/segfault/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/segfault/perl5"; export PERL_MM_OPT;

autoload -U compinit && compinit

PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Termite current directory
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi

# Disable bracketed paste mode for terminals that
#   doesn't support escape sequences (like Emacs shell)
if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

# Enable kde plasma blur effect
if [[ $(ps --no-header -p $PPID -o comm) =~ '^yakuake|konsole$' ]]; then
        for wid in $(xdotool search --pid $PPID); do
            xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $wid; done
fi

# Use most as pager
export PAGER="most"
