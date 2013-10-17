#!/bin/bash

VIMDIR=$HOME/.vim

mkdir $WORKDIR

cp -pr `pwd`/vim_settings/.vim $VIMDIR
mkdir $VIMDIR/bundle
git clone https://github.com/Shougo/neobundle.vim $VIMDIR/bundle/neobundle.vim.git
