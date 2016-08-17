#!/bin/sh
#################################################
# Setup
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap phinze/homebrew-cask
brew install brew-cask
#################################################

# Mac Utilities
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install alfred
brew cask install divvy
brew cask install appcleaner
#brew cask install cleanmymac
#################################################

# Development
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install iterm2
brew cask install gitup
brew cask install atom
brew cask install sublime-text
brew cask install mou
brew cask install cyberduck
brew cask install filezilla
brew cask install firefox
brew cask install google-chrome
#brew cask install sketch
#brew install vim
#brew cask install bear (when available)
#brew cask install mamp-pro
#brew cask install parallels-desktop
#################################################

# Communications
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install skype
brew cask install slack
brew cask install ryver
brew cask install teamviewer
#brew cask install frenz (when available)
#################################################

# Fun
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install spotify
brew cask install steam
brew cask install curse
#################################################
