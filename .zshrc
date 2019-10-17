# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# alias
alias ll="ls -Gl"
alias la="ls -Gla"

# basic
## show exit value if not 0
setopt print_exit_value
setopt correct
setopt list_packed

## history
export EDITOR='vim'
export HISTSIZE=1000
export SAVEHIST=100000
export HISTFILE=${HOME}/.zsh_history
setopt hist_ignore_all_dups
setopt EXTENDED_HISTORY
setopt hist_reduce_blanks
setopt hist_verify
setopt share_history

### show all history
function history-all { history -E 1 }

## directory stack
DIRSTACKSIZE=100
setopt auto_pushd
setopt pushd_ignore_dups

## prompt color
autoload -Uz colors
colors

# completion
fpath=(`brew --prefix`/Cellar/zsh-completions/0.31.0/share/zsh-completions $fpath)
fpath=(path/to/zsh-completions/src $fpath)
autoload -U compinit
compinit -u

# git
setopt PROMPT_SUBST
source ~/.git-prompt.sh

#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWUPSTREAM=1
#GIT_PS1_SHOWUNTRACKEDFILES=1

PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%F{6}[$(date "+%Y/%m/%d %H:%M:%S")]%f %F{4}${_prompt_sorin_pwd}%f%F{2}$(__git_ps1 " (%s)")%f%(!. %B%F{1}#%f%b.)${editor_info[keymap]} '

# z
source `brew --prefix`/etc/profile.d/z.sh

# peco
## history
function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

## z
function peco-z-search
{
  local res=$(z | sort -rn | cut -c 12- | peco)
  if [ -n "$res" ]; then
    BUFFER+="cd $res"
    zle accept-line
  else
    return 1
  fi
}
zle -N peco-z-search
bindkey '^f' peco-z-search

## ghq
function peco-ghq
{
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-ghq
bindkey '^g' peco-ghq

