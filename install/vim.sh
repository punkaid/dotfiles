#!/bin/sh

# Install Pathogen
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
mkdir -p ~/.vim/autoload ~/.vim/bundle 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
#################################################

cd ~/.vim/bundle

# Integration
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
git clone https://github.com/scrooloose/nerdtree
git clone https://github.com/kien/ctrlp.vim
#################################################

# Interface
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
git clone https://github.com/bling/vim-airline
git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle
git clone https://github.com/altercation/vim-colors-solarized
#################################################

# Syntax
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
git clone https://github.com/evidens/vim-twig
#################################################

# Helpers
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
git clone https://github.com/tpope/vim-surround
git clone https://github.com/raimondi/delimitmate
#################################################
