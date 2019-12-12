# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# alias
alias ll="ls -Gl"
alias la="ls -Gla"

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

# gcloud sdk
## The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/tatsuya.atsumi/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/tatsuya.atsumi/google-cloud-sdk/path.zsh.inc'; fi

## The next line enables shell command completion for gcloud.
if [ -f '/Users/tatsuya.atsumi/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/tatsuya.atsumi/google-cloud-sdk/completion.zsh.inc'; fi
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# paths
## home bin
export PATH="/Users/tatsuya.atsumi/bin:$PATH"

## npm bin
export PATH="/Users/tatsuya.atsumi/.nodenv/versions/8.11.3/bin:$PATH"

## nuxt
export PATH="/Users/tatsuya.atsumi/IdeaProjects/dalmatia/webapp-client-v2/node_modules/nuxt/bin:$PATH"

## Setting PATH for Python 3.7
## The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

## Setting user bin path
export PATH="/Users/tatsuya.atsumi/bin":${PATH}

## firebase-tools
export PATH="/Users/tatsuya.atsumi/.nodenv/versions/10.11.0/lib/node_modules/firebase-tools/lib/bin":${PATH}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# tmux setting
function precmd() {
  if [ ! -z $TMUX ]; then
    tmux refresh-client -S
  fi
}

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
  tmux
fi
