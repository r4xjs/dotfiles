cclear="free && sync && echo 3 > /proc/sys/vm/drop_caches && free"

# ---------- prompt ----------
# {{{1
autoload -U promptinit 
promptinit
prompt adam2
# 1}}}

# ---------- options ----------
# {{{1
setopt appendhistory extendedglob nomatch
unsetopt beep notify
unsetopt correctall
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history
setopt share_history
# 1}}}

# ---------- auto completion ----------
# {{{1
autoload -Uz compinit
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
# 1}}}

# ---------- key bindings ----------
# {{{1
bindkey -v
bindkey "^R" history-incremental-pattern-search-backward 
bindkey "^E" history-incremental-pattern-search-forward
# 1}}}

# ---------- aliases ----------
# {{{1
alias ls='ls --color=auto'
alias sl='ls --color=auto'
alias ll='ls -lh'

alias ssh-p='ssh -o PreferredAuthentications=password'
alias rgrep='grep -Ri --color=always'

alias rsync='rsync -arvphsS --progress'

alias grep='grep --color=auto'
alias ip='ip -c'

if  hash nvim 2>/dev/null; then
    alias vim='nvim'
fi
# 1}}}

# ---------- history settings ----------
# {{{1
HISTSIZE="2000"
HISTFILE="$HOME/.history"
SAVEHIST="$HISTSIZE"
# 1}}}

# ---------- exports ----------
# {{{1
export PATH="$PATH":"${HOME}/bin":"${HOME}/.local/bin":"${HOME}/Android/Sdk/platform-tools"
export wlan0=wlx00c0ca56bbff
export okular_cache=/home/user/.config/okularrc
if hash nvim 2>/dev/null; then
    export EDITOR=/usr/bin/nvim
else
    export EDITOR=/usr/bin/vim
fi
# 1}}}

source ~/.profile

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
