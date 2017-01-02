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
brew cask install itsycal
brew cask install evernote
# brew cask install cleanmymac
#################################################

# Development
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install iterm2
brew cask install gitup
brew cask install atom
brew cask install sublime-text
# brew cask install cyberduck
brew cask install filezilla
brew cask install firefox
brew cask install google-chrome
brew cask install postman
# brew cask install sketch
# brew install vim
# brew cask install mamp-pro
# brew cask install parallels-desktop
#################################################

# Communications
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install ryver
brew cask install teamviewer
# brew cask install line
# brew cask install franz
#################################################

# Fun
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
brew cask install spotify
brew cask install steam
brew cask install curse
brew cask install battle-net
brew cask install razer-synapse
#################################################
