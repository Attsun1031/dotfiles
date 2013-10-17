#!/bin/bash

VIMDIR=$HOME/.vim

if [ -d "$VIMDIR" ]
then
  mv $VIMDIR $HOME/vim.$DATETIME
fi

if [ -e "$HOME/.vimrc" ]
then
  mv $HOME/.vimrc $HOME/vimrc.$DATETIME
fi

cp -pr `pwd`/vim_settings/.vim $VIMDIR
mkdir $VIMDIR/bundle
git clone https://github.com/Shougo/neobundle.vim $VIMDIR/bundle/neobundle.vim.git
