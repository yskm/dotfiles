## prompt
setopt transient_rprompt
autoload -Uz vcs_info

zstyle ':vcs_info:*' formats '[%S][%b@%r]'
zstyle ':vcs_info:*' actionformats '[%S][%b(%a)@%r]'

precmd() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

PROMPT="[%n@%m]$ "
RPROMPT="%1(v|%1v|[%~])"

## history
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

## color
CLICOLOR='true'
LSCOLORS='di=34:ln=36:or=33'
export CLICOLOR LS_COLORS

## zsh config

bindkey -e

autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^T' history-incremental-pattern-search-forward

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

setopt auto_cd
setopt auto_pushd

## alias
alias ll='ls -alF'
alias h='history 30'
alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'

## other

### rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

### phpenv
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init - zsh)"

