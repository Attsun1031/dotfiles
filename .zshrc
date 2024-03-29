# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

autoload -U select-word-style
select-word-style bash

# gnu commands
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/grep/libexec/gnuman:$MANPATH"

# alias
alias ll='ls -l --color=auto'
alias la="ls -la --color=auto"
alias gi="git"
alias gip="git pull"
alias pc="pbcopy"
#alias readlink=greadlink
alias poetry="SYSTEM_VERSION_COMPAT=1 poetry"

# GNU
alias date='gdate'

# gh alias
alias ghv="gh repo view --web"
alias ghp="gh pr create --web"
alias ghrw="gh run watch -i1"
alias ghrv="gh run view --web"

# help
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help
alias help=run-help

## colordiff
if [[ -x `which colordiff` ]]; then
  alias diff='colordiff -u'
else
  alias diff='diff -u'
fi

# basic
## show exit value if not 0
setopt print_exit_value
setopt correct
setopt list_packed

## history
export EDITOR='vim'
export HISTSIZE=10000
export SAVEHIST=1000000
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
fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit -u
if type "kubectl" > /dev/null; then
    source <(kubectl completion zsh)
fi

# git
setopt PROMPT_SUBST
source ~/.git-prompt.sh

#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWUPSTREAM=1
#GIT_PS1_SHOWUNTRACKEDFILES=1

# prompt
## customized sorin
#PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%F{6}[$(date "+%y/%m/%d %H:%M:%S")]%f %F{4}${_prompt_sorin_pwd}%f%F{2}$(__git_ps1 " (%s)")%f%(!. %B%F{1}#%f%b.)${editor_info[keymap]} '
## powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
autoload -Uz promptinit
promptinit
prompt powerlevel10k

# z
source `brew --prefix`/etc/profile.d/z.sh

# peco
## history
function peco-history-selection() {
    BUFFER=`history -n 1 | tac | awk '!a[$0]++' | peco`
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
export GHQ_ROOT="/Users/tatsuya.atsumi/repos"
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

# gcloud sdk
## The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tatsuya.atsumi/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/tatsuya.atsumi/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/Users/tatsuya.atsumi/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/tatsuya.atsumi/google-cloud-sdk/completion.zsh.inc'; fi
#export PATH="$HOME/.nodenv/bin:$PATH"
#eval "$(nodenv init -)"

# paths
## home bin
export PATH="/Users/tatsuya.atsumi/bin:$PATH"

## Setting PATH for Python 3.7
## The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"

# pip --user directory
export PATH="/Users/tatsuya.atsumi/Library/Python/3.7/bin:${PATH}"

## Setting user bin path
export PATH="/Users/tatsuya.atsumi/bin":${PATH}

## firebase-tools
export PATH="/Users/tatsuya.atsumi/.nodenv/versions/10.11.0/lib/node_modules/firebase-tools/lib/bin":${PATH}

# pyenv path
export PATH="/Users/tatsuya.atsumi/.pyenv/shims:${PATH}"

# pipenv path
export PATH="/usr/local/Cellar/pipenv/2018.11.26_4/bin:${PATH}"

# self install python
export PATH="/Users/tatsuya.atsumi/Library/Python/3.7/bin:${PATH}"

# istio
export PATH=$PATH:$HOME/.istioctl/bin

# tmux setting
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# 初回シェル時のみ tmux実行
### if [ $SHLVL = 1 ]; then
###   tmux
### fi

export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# dev-n
export MY_DEV_N=atsumi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"

# iterm2
source ~/.iterm2_shell_integration.zsh

# direnv
eval "$(direnv hook zsh)"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# go pkgs
export PATH="${HOME}/go/bin:${PATH}"

# jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# gcloud command path
export CLOUDSDK_PYTHON=/Users/tatsuya.atsumi/.pyenv/shims/python3.8

