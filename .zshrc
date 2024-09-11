
# The following lines were added by compinstall
# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' (%b)'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST

# PROMPT='%B%F{108}%1~%f%b%B%F{109}${vcs_info_msg_0_}%f %F{167}>%f%b '
PROMPT='%B%F{14}%1~%f%b%B%F{109}${vcs_info_msg_0_}%f %F{167}>%f%b '


setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"
setopt inc_append_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


bindkey -s '^a' '^uqalc \n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null



# aliases


# alias ls='ls --color=auto'
alias grep='grep --color=auto'


alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

alias exa="exa -t=mod --time-style=default --sort=type --git"
alias ls='ls --color=auto -h --group-directories-first'



alias vi='vim'
alias ll='exa -l'
alias la='exa -la'
alias yay='yay --color=auto'

alias i='doas pacman -S'
alias u='doas pacman -Syu'
alias q='doas pacman -Ss'
alias r='doas pacman -Rns'

# alias tree='tree -C --du -h'
alias tree='exa -T'
alias catt='bat'
alias cat='bat -pp'
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -vI"
alias mkd="mkdir -pv"
alias diff="diff --color=auto"
alias nmcli="nmcli --color=auto"
alias kf="ps aux | fzf | awk '{print $2}' | xargs kill"
alias vf='vi $(find . -type f | fzf)'

# alias nnn='nnn -Rre'


# git aliases
#
#
alias gb="git branch"
alias gc="git commit -m"
alias ga="git add"
alias gl="git log --all --graph"
alias gs="git status"
alias gp="git push -u"
alias gch="git checkout"
# End of lines configured by zsh-newuser-install
#
#
#
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
