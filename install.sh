#!/bin/bash

echo "Initializing basic system configurations =-=-=-=-=-=-=-=-=-=-=-"

echo "Creating working directories"
code="$HOME/code"
for directory in $code "$HOME/.bin" "$code/dev" "$code/repos" "$code/libs"; do
  if [ ! -d $directory ]; then
    mkdir $directory
  fi
done

echo "Creating .env"
if [ ! -f $HOME/.env ]; then
  touch $HOME/.env
fi

echo "Setting up 9 workspaces"
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ vsize 3
gsettings set org.compiz.core:/org/compiz/profiles/unity/plugins/core/ hsize 3

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

echo "Installing missing programs -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

if ! command -v "vim" > /dev/null; then
    echo "Vim is not installed."
    echo "Installing Vim"
    sudo apt-get -y install vim
else
    echo "Vim is already installed!"
fi

if ! command -v "wget" > /dev/null; then
    echo "Wget is not installed."
    echo "Installing Wget"
    sudo apt-get -y install wget
else
    echo "Wget is already installed!"
fi

if ! command -v "composer" > /dev/null; then
    echo "Composer is not installed."
    echo "Installing Composer"
    sudo apt-get -y install composer
else
    echo "Composer is already installed!"
fi

if ! command -v "atom" > /dev/null; then
    echo "Atom is not installed."
    echo "Installing Atom"
    wget -P /tmp/ https://github.com/atom/atom/releases/download/v1.6.1/atom-amd64.deb
    sudo dpkg --install /tmp/atom-amd64.deb
    apm install --packages-file atom/package-list.txt
else
    echo "Atom is already installed!"
    echo "Checking for outdated Atom packages."
    apm upgrade
fi

if ! command -v "mysql" > /dev/null; then
    echo "LAMP stack not installed"
    echo "Installing LAMP"
    sudo apt-get -y install apache2
    sudo apt-get -y install php7.0
    sudo apt-get -y install mysql-server
    sudo apt install -y libapache2-mod-php7.0
else
    echo "LAMP is installed"
fi

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

echo "Creating symlink =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

DOTFILES="$HOME/dotfiles/tolink"
for file in $(ls $DOTFILES); do
  if [ ! -L "$HOME/.$file" ]; then
    echo "Linking $file"
    ln -s $DOTFILES/$file $HOME/.$file
  fi
done

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

echo "Installing fonts =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

SOURCEFONTS="$HOME/dotfiles/resources/fonts"
TARGETFONTS="$HOME/.font"
for font in $(ls $SOURCEFONTS); do
  if [ ! -e "$TARGETFONTS/$font" ]; then
    echo "Copying $font"
    cp $SOURCEFONTS/$font $TARGETFONTS/$font
  fi
done

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

echo "Installing vim pluggins -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

cd ~/.vim/bundle
git clone https://github.com/tpope/vim-surround
git clone https://github.com/vim-scripts/delimitMate.vim
git clone https://github.com/kien/ctrlp.vim
git clone https://github.com/bling/vim-airline
git clone https://github.com/altercation/vim-colors-solarized
git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle

echo "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"

echo "All done master!"
