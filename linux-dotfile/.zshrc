# Path to your oh-my-zsh installation.
  export ZSH=/home/cowlog/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
plugins=(svn git github gitignore archlinux systemd tmux z d ls zsh_stats docker vagrant python pip)

# Load zsh-syntax-highlighting.
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Load zsh-autosuggestions.
source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh

# Enable autosuggestions automatically.
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/cowlog/.bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

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
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ls="ls --color=auto"
# alias steam="LD_PRELOAD=/usr/lib/libasound.so.2 primusrun steam > /dev/null 2>&1 &"
# alias javaide="/opt/intellij-idea/bin/idea.sh > /dev/null 2>&1 &"

# Percol
[ $(uname -s | grep -c CYGWIN) -eq 1 ] && OS_NAME="CYGWIN" || OS_NAME=`uname -s`
function pclip() {
    if [ $OS_NAME == CYGWIN ]; then
        putclip $@;
    elif [ $OS_NAME == Darwin ]; then
        pbcopy $@;
    else
        if [ -x /usr/bin/xsel ]; then
            xsel -ib $@;
        else
            if [ -x /usr/bin/xclip ]; then
                xclip -selection c $@;
            else
                echo "Neither xsel or xclip is installed!"
            fi
        fi
    fi
}

# search the file and pop up dialog, then put the full path in clipboard
function baseff()
{
    local fullpath=$*
    local filename=${fullpath##*/} # remove "/" from the beginning
    filename=${filename##*./} # remove  ".../" from the beginning
    # Only the filename without path is needed
    # filename should be reasonable
    local cli=`find . -not -iwholename '*/vendor/*' -not -iwholename '*/bower_components/*' -not -iwholename '*/node_modules/*' -not -iwholename '*/target/*' -not -iwholename '*.svn*' -not -iwholename '*.git*' -not -iwholename '*.sass-cache*' -not -iwholename '*.hg*' -type f -path '*'${filename}'*' -print | ~/.bin/percol.py`
    # convert relative path to full path
    echo $(cd $(dirname $cli); pwd)/$(basename $cli)
}

function ff()
{
    local cli=`baseff $*`
    #echo ${cli} | sed 's%^'${HOME}'%~%'
    #echo -n ${cli}  | sed 's%^'${HOME}'%~%' | pclip
    echo ${cli}
    echo -n ${cli} | pclip
}

function cf()
{
    local cli=`baseff $*`
    local p=`cygpath -w $cli`
    echo ${p}
    echo -n ${p} | pclip;
}

function h () {
    # reverse history, pick up one line, remove new line characters and put it into clipboard
    if [ -z "$1" ]; then
        history | sed '1!G;h;$!d' | ~/.bin/percol.py | sed -n 's/^ *[0-9][0-9]* *\(.*\)$/\1/p'| tr -d '\n' | pclip
    else
        history | grep "$1" | sed '1!G;h;$!d' | ~/.bin/percol.py | sed -n 's/^ *[0-9][0-9]* *\(.*\)$/\1/p'| tr -d '\n' | pclip
    fi
}

function glsf () {
    local str=`git --no-pager log --oneline --stat $* |  ~/.bin/percol.py`
    if [[ $str =~ ^[[:space:]]*([a-z0-9A-Z_.\/-]*).*$ ]]; then
        echo -n ${BASH_REMATCH[1]} |pclip;
        echo ${BASH_REMATCH[1]}
    fi
}

# The Fuck
eval "$(thefuck --alias)"
eval "$(thefuck --alias FUCK)"

# TMUX_POWERLINE
# JiLin
# export TMUX_POWERLINE_SEG_WEATHER_LOCATION="2138121"
# DongGuan
export TMUX_POWERLINE_SEG_WEATHER_LOCATION="2161842"

# TMUX
# if [[ -z "$TMUX" ]] ;then
#     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#     if [[ -z "$ID" ]] ;then # if not available create a new one
#         tmux new-session
#     else
#         tmux attach-session -t "$ID" # if available attach to it
#     fi
# fi

# if [[ -z "$TMUX" ]] ;then
#     ID="`tmux ls | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
#     if [[ -z "$ID" ]] ;then # if not available create a new one
#         tmux new-session
#     else
#         tmux attach-session -t "$ID" # if available attach to it
#     fi
# fi

# TMUX
# if which tmux 2>&1 >/dev/null; then
#     #if not inside a tmux session, and if no session is started, start a new session
#     test -z "$TMUX" && (tmux -2 attach || tmux -2 new-session)
# fi

export TERM=xterm-256color

export NVM_DIR="/home/cowlog/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# .gitignore
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# Algorithm 4
export PATH=$PATH:$HOME/algs4/bin

# Byobu
_byobu_sourced=1 . /usr/bin/byobu-launch

# tmuxinator
source ~/.bin/tmuxinator.zsh
