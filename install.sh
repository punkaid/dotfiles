#!/bin/sh

code="$HOME/code"

echo "Creating working directories ......................"
for directory in $code "$HOME/.bin" "$code/dev" "$code/repos" "$code/libs"; do
  if [ ! -d $directory ]; then
    mkdir $directory
    echo "$directory created"
  fi
done
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Installing composer ..............................."
rm "$HOME/.bin/composer"
cd "$code/dev"
curl -sS https://getcomposer.org/installer | php
ln -s $code/dev/composer.phar $HOME/.bin/composer
echo "Composer installed"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Installing oh-my-zsh .............................."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  curl -L http://install.ohmyz.sh | sh
  sudo chsh -s $(which zsh) $(whoami)
  rm $HOME/.zshrc
fi
echo "Oh-my-zsh installed"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Creating simlink .................................."
if [ ! -f $HOME/.env ]; then
  touch $HOME/.env
  echo "~/.env created"
fi
DOTFILES="$HOME/dotfiles/tolink"
for file in $(ls $DOTFILES); do
  if [ ! -L "$HOME/.$file" ]; then
    ln -s $DOTFILES/$file $HOME/.$file
    echo "$file linked"
  fi
done
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Installing fonts .................................."
SOURCEFONTS="$HOME/dotfiles/resources/fonts"
TARGETFONTS="$HOME/Library/Fonts"
for font in $(ls $SOURCEFONTS); do
  if [ ! -e "$TARGETFONTS/$font" ]; then
    cp $SOURCEFONTS/$font $TARGETFONTS/$font
    echo "$font installed"
  fi
done
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Installing all softwares .........................."
bash ./brew.sh
echo "Sorfwares installed"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Setting up Mac config ............................."
bash ./osx
echo "Config setted"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Cloning vim plugins ..............................."
bash ./vim
echo "Plugins cloned"
echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "All done master!"
