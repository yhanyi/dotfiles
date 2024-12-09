# Enable Fuzzy Finding using fcd
fcd() {
  local dir
  dir=$(find ${1:-.} -type d -not -path '*/\.*' 2> /dev/null | fzf +m) && cd "$dir"
}

# Checks if tmux is installed and starts it up.
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# Alias for find and edit utility.
alias fe="~/.scripts/fe.sh"

# Alias for quicktesting utility.
alias cpptest="~/.scripts/quicktest.sh cpp"
alias gotest="~/.scripts/quicktest.sh go"
alias rusttest="~/.scripts/quicktest.sh rust"

# Path to KDB+/Q installation.
export QHOME="~/Code/m64"
alias q="QHOME=~/Code/m64 rlwrap -r ~/Code/m64/m64/q"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git web-search)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# LLVM and C++ configuration
export LLVM_PATH="/opt/homebrew/opt/llvm"
export PATH="$LLVM_PATH/bin:$PATH"

# Force use of LLVM/Clang instead of system GCC
export CC="$LLVM_PATH/bin/clang"
export CXX="$LLVM_PATH/bin/clang++"
export CMAKE_C_COMPILER="$LLVM_PATH/bin/clang"
export CMAKE_CXX_COMPILER="$LLVM_PATH/bin/clang++"

# Include and library paths
export CPATH="$LLVM_PATH/include:/opt/homebrew/include:/usr/local/include"
export LIBRARY_PATH="$LLVM_PATH/lib:/opt/homebrew/lib:/usr/local/lib"
export LD_LIBRARY_PATH="$LLVM_PATH/lib:/opt/homebrew/lib:/usr/local/lib"
export CPLUS_INCLUDE_PATH="$LLVM_PATH/include/c++/v1:$LLVM_PATH/include:/opt/homebrew/include:/usr/local/include"

# Enhanced C++ compilation alias using clang++
alias gpp='clang++ -std=c++17 -Wall -Wextra -Wshadow -Wconversion -Wcast-qual -Wcast-align -Wno-unused-result'

# Alias for updating code folder.
alias save='cd ~/Comp && git add . && git commit -m "+" && git push origin main'

# LSP configuration for nvim
export CLANGD_PATH="$LLVM_PATH/bin/clangd"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Verify C++ environment
check_cpp_env() {
    echo "Checking C++ environment..."
    echo "C++ Compiler: $(which clang++)"
    echo "LLVM Path: $(which llvm-config)"
    echo "Clangd: $(which clangd)"
    echo "Include paths:"
    echo $CPLUS_INCLUDE_PATH | tr ':' '\n'
    echo "\nChecking if standard headers are accessible:"
    echo "#include <iostream>" > /tmp/test.cpp
    echo "int main() { return 0; }" >> /tmp/test.cpp
    clang++ -v /tmp/test.cpp -o /tmp/test 2>&1
    rm /tmp/test.cpp 2>/dev/null
    rm /tmp/test 2>/dev/null
}

# Alias for checking environment
alias check_cpp='check_cpp_env'

eval "$(starship init zsh)"
