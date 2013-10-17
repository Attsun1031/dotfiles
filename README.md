# これはなに？
.vimなど、よく使う環境設定ファイル

# インストール手順
1. git clone https://github.com/Attsun1031/dotfiles.git
2. cd dotfiles
3. ./install.sh
4. vimを起動し、NeoBundleInstall（エラーが出るが無視）
5. cd $HOME/.vim/bundle/syntastic/plugin
6. patch < dotfiles/vim_settings/patches/syntastic.vim.p0
