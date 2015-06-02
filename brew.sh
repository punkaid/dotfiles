#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap phinze/homebrew-cask
brew install brew-cask
brew install vim

brew cask install alfred
brew cask install appcleaner
brew cask install cyberduck
brew cask install divvy
brew cask install firefox
brew cask install gimp
brew cask install google-chrome
brew cask install iterm2
#brew cask install mamp-pro
brew cask install mou
#brew cask install parallels-desktop
brew cask install skype
brew cask install slack
brew cask install steam
brew cask install teamviewer
brew cask install vlc
