# install zsh and others
```
brew install zsh

# install prezto
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

# install zsh-completion
brew instsall zsh-completions

# install other tools
brew install ghq
brew install peco
brew install hub

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
