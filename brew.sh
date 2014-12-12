#!/bin/sh

ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew tap phinze/homebrew-cask
brew install brew-cask

brew cask install google-chrome
brew cask install alfred
brew cask install cyberduck
brew cask install gimp
brew cask install slack
brew cask install iterm2
brew cask install mou
brew cask install pgadmin3
brew cask install sequel-pro
brew cask install skype
brew cask install sublime-text
brew cask install virtualbox
brew cask install vlc
brew cask install thunderbird
brew cask install teamviewer
