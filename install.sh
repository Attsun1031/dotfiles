#!/bin/bash

VIMDIR=$HOME/.vim
DATETIME=`date "+%Y%m%d%H%M%S"`

if [ -d "$VIMDIR" ]
then
  mv $VIMDIR $HOME/vim.$DATETIME
fi

if [ -e "$HOME/.vimrc" ]
then
  mv $HOME/.vimrc $HOME/vimrc.$DATETIME
fi

mkdir $HOME/.vimundo

cp -pr `pwd`/vim_settings/.vim $VIMDIR
mkdir $VIMDIR/bundle
git clone https://github.com/Shougo/neobundle.vim $VIMDIR/bundle/neobundle.vim.git


## python
#cp -p python/.pythonrc.py $HOME/
#echo 'export PYTHONSTARTUP=$HOME/.pythonrc.py' >> $HOME/.bashrc
