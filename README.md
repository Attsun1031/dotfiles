# dotfiles
dotfiles for me

## install
```
brew install zsh

# install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# install zsh-completion
brew install zsh-completions

# install other tools
brew install ghq
brew install peco
brew install hub
brew install z
brew install tmux
brew install reattach-to-user-namespace
brew install colordiff

# install dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein
## paste

# fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
## iTerm2で以下設定
## Preferences -> Profile -> Text -> Font で "Noto mono for powerline"に変更

# after load .zshrc
rm -f ~/.zcompdump; compinit
```

