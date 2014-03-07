DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# zsh setup
if [[ $EUID -eq 0 ]] ; then
  rm -rf /etc/zsh > /dev/null 2&>1
  ln -s ~/dotfiles/zsh /etc/zsh
else
  curl -L https://github.com/awkisopen/oh-my-zsh/raw/master/tools/install.sh | zsh
fi

# common portage options setup
rm /etc/make.conf > /dev/null 2>&1
if [ ! -f /etc/portage/.modified ]; then
  cp $DIR/portage/default/make.conf /etc/portage/make.conf
  cp $DIR/portage/default/package.use /etc/portage/package.use
  touch /etc/portage/.modified
fi

# vimrc
ln -s $DIR/vim/vimrc ~/.vimrc
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
vim +BundleInstall +qall
cd ~/.vim/bundle/YouCompleteMe && ./install.sh

# tmux
ln -s $DIR/tmux/tmux.conf ~/.tmux.conf
if [[ $EUID -eq 0 ]] ; then
  git clone https://github.com/Lokaltog/powerline.git /opt/powerline
  cd /opt/powerline && ./setup.py build && ./setup.py install
fi

# git
ln -s $DIR/git/gitconfig ~/.gitconfig
