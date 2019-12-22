# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
TRAINING_FOLDER=$HOME/training
GIT_FOLDER=$HOME/repos
DROPBOX_FOLDER=$HOME/Dropbox

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
COMPLETION_WAITING_DOTS="true"

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
  node
  npm
  npx
  nvm
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Add all highlighting to zsh syntax hightlights
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# Taken from https://github.com/zsh-users/fizsh/blob/master/fizsh-dev/scripts/fizsh-miscellaneous.zsh
################################################
#
# Rebind tab so that it uses syntax-highlighting
#
# This is a bug in the syntax highlighting system (https://github.com/zsh-users/zsh-syntax-highlighting/issues/102)
# We work around it by calling all types of highlighters explictily
#

function _fizsh-expand-or-complete-and-highlight() {
  zle expand-or-complete
  _zsh_highlight_highlighter_brackets_paint
  _zsh_highlight_highlighter_main_paint
  _zsh_highlight_highlighter_cursor_paint
  _zsh_highlight_highlighter_pattern_paint
  _zsh_highlight_highlighter_root_paint
}

function backup() {
  # expect file-name as input; e.g .zshrc
 cp "$1"{,-backup."$(date +%Y-%m-%d_%H_%M_%S)"} 
}
function zshrc-deploy-from-repo(){
  backup ~/.zshrc
  cp $GIT_FOLDER/osx-computer/.zshrc ~/.zshrc
}
function save-computer-config(){
  cp ~/.zshrc $GIT_FOLDER/osx-computer/.zshrc
}
function zshrc-copy-to-repo(){
  cp ~/.zshrc $GIT_FOLDER/osx-computer/.zshrc
}
alias zshrc-copy-to-repo="zshrc-copy-to-repo"

function training-to-dropbox(){
  # remove node_modules first
  find $TRAINING_FOLDER -type d -name "node_modules" -exec rm -rf {} +
  # -a : preserve structure and attributes but not directory structure
  # -p : preserve attributes
  # -R : copy directory and sub-tree
  # -v : be verbose with output
  cp -a -v -p $TRAINING_FOLDER/. $DROPBOX_FOLDER/training
}
alias training-push="training-to-dropbox"

function training-from-dropbox(){
  # -a : preserve structure and attributes but not directory structure
  # -p : preserve attributes
  # -R : copy directory and sub-tree
  # -v : be verbose with output
  cp -a -p -R -v $DROPBOX_FOLDER/training/. $TRAINING_FOLDER/ 
}
alias training-pull="training-from-dropbox"

function training() {
  cd $TRAINING_FOLDER/"$@" && code .
}

function repos() {
  cd $GIT_FOLDER/"$@" && code .
}

function find-folder() {
  find ~/ -name "$@" -type d
}
function zsh-help(){
  google-chrome https://github.com/robbyrussell/oh-my-zsh/wiki/Cheatsheet
}

alias s="git status"
function config-the-git(){
  git config --global --add rebase.autostash true # don't make me stash manually and then pop it on git pull (rebase default)
}
function gitlog-search(){
  git log --grep="$@" --format=fuller
}

# Colors
ESC_SEQ="\x1b["
RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
BLUE=$ESC_SEQ"34;01m"
MAGENTA=$ESC_SEQ"35;01m"
CYAN=$ESC_SEQ"36;01m"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
