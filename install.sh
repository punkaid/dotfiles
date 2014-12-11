#!/bin/sh

code="$HOME/code"

for directory in $code "$HOME/.bin" "$code/dev" "$code/repos" "$code/libs"; do
	if [ ! -d $directory ]; then
		mkdir $directory
	fi
done

if [[ ! `uname` == 'Darwin' ]]; then
	sudo apt-get install vim git curl zsh php5 php5-json
fi

rm "$HOME/.bin/composer"
cd "$code/dev"
curl -sS https://getcomposer.org/installer | php
ln -s $code/dev/composer.phar $HOME/.bin/composer

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	curl -L http://install.ohmyz.sh | sh
	sudo chsh -s $(which zsh) $(whoami)
	rm $HOME/.zshrc
fi

if [[ -f "$HOME/.env" ]]; then
  touch $HOME/.env
fi

DOTFILES="$HOME/dotfiles/tolink"

for file in $(ls $DOTFILES); do
	if [ ! -L "$HOME/.$file" ]; then
		echo "Linking $file"
		ln -s $DOTFILES/$file $HOME/.$file
	fi
done

echo "All done master!"
