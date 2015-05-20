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

# require: 'brew install zsh-completions'
fpath=(/usr/local/share/zsh-completions(N-/) $fpath)

autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward

autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr
add-zsh-hook chpwd chpwd_recent_dirs

setopt auto_cd
#setopt auto_pushd
setopt no_beep
setopt no_flow_control
setopt ignore_eof

## alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ll='ls -alF'
alias ff='find . -type f'
alias fd='find . -type d'
alias fn='find . -name'
alias h='history 30'
alias cleanup='find . -type f -name "*.DS_Store" -ls -delete'

alias cdv='cd $(vagrant global-status | grep -e "^[a-z0-9]\{7\}" | tr -s " " | cut -d" " -f 5 | peco)'

alias http='python -m SimpleHTTPServer'

alias -g L='| less'
alias -g X='| xargs'
alias -g XG='| xargs grep'

## other

### rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

### phpenv
export PATH="$HOME/.phpenv/bin:$PATH"
eval "$(phpenv init - zsh)"

if [ -e ~/.zshlocal ]; then
  source ~/.zshlocal
fi

### golang
export GOPATH="$HOME/.golang"
export PATH="$HOME/.golang/bin:$PATH"
