# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/.emacs.d/bin:$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/oh-my-zsh"

export DEFAULT_USER="simon"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
if [[ -n $DISPLAY ]]
then
	ZSH_THEME="agnoster"
else
	ZSH_THEME="geoffgarside"
fi

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
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

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
 HIST_STAMPS="dd/mm/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	sudo
	timer
	z
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
if [ -d /etc/apt ]
then
	alias yay='sudo apt install'
	alias yeet='sudo apt purge'
	alias search='apt search'
	#alias update='sudo apt-get update && sudo apt-get -y dist-upgrade && doom upgrade && omz update'
elif [ -d /etc/paru ]
then
	alias yay='paru --limit 10 --skipreview --topdown'
	alias yeet='paru -Rsn'
	alias search='paru -Ss --topdown'
	#alias update='paru -Syu --skipreview && paru -Scc --noconfirm && protonup -y && doom upgrade && omz update'
elif [ -d /etc/yay ]
then
    alias yay='yay --limit 10 --skipreview --topdown'
	alias yeet='yay -Rsn'
	alias search='yay -Ss --topdown'
	#alias update='yay -Syu --skipreview && yay -Scc --noconfirm && protonup -y && doom upgrade && omz update'
fi

up() {
	## If yay is installed then update with yay
	if [[ -f /usr/bin/yay ]]
	then
		yay -Syu --skipreview && yay -Scc --noconfirm
	## If paru is installed then update with paru
	elif [[ -f /usr/bin/paru ]]
	then
		paru -Syu --skipreview && paru -Scc --noconfirm
	## Since there's little chance that I'll use pacman or another distro
	# than Arch or Debian, updates will be made with apt-get if yay and paru
	# aren't installed
	else
		sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
	fi
	
	## Verify that doom is installed	
	if [[ -f ~/.emacs.d/bin/doom ]]
	then
		doom upgrade
	fi

	## Verify that flatpak is installed
	if [[ -f /usr/bin/flatpak ]]
	then
		flatpak update -y
	fi

	omz update
}

alias e="emacsclient -c -a emacs"

# Aliases related to rc file
rc=~"/.zshrc" # Useful if, for some strange reason, I ever want to switch to another shell

alias erc="vim "$rc "&& source "$rc
alias src="source "$rc

# Git aliases
alias config='/usr/bin/git --git-dir=$HOME/dotfiles.git --work-tree=$HOME'
alias status='git status'
alias commit='git commit'
alias push='git push'
alias add='git add'

# fd alias for debian-based distros
if [ -f /usr/bin/fdfind ]
then
	alias fd='fdfind'
fi

# If zsh Highlighting is install source it
if [ -d /usr/share/zsh-syntax-highlighting ]
then
	source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# If zsh autosuggestion is install source it
if [ -d /usr/share/zsh-autosuggestions ]
then
	source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Solve terminal issues with SSH
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

export CLASSPATH=.:$HOME/libs/
