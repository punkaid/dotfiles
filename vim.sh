#!/bin/sh

# Create bundle folder to store plugin and
# install Patogen
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
mkdir -p ~/.vim/autoload ~/.vim/bundle 
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
#################################################

# Go to bundle folder and clone all needed plugins
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
cd ~/.vim/bundle
# A tree explorer plugin for vim.
git clone https://github.com/scrooloose/nerdtree
# Full path fuzzy file, buffer, mru, tag, ... finder for Vim.
git clone https://github.com/kien/ctrlp.vim
# Lean & mean status/tabline for vim that's light as air
git clone https://github.com/vim-airline/vim-airline
# Toggles between relative and absolute line numbers automatically
git clone https://github.com/jeffkreeftmeijer/vim-numbertoggle
# Quoting/parenthesizing made simple
git clone https://github.com/tpope/vim-surround
# Provides insert mode auto-completion for quotes, parens, brackets, etc.
git clone https://github.com/raimondi/delimitmate
# theme color and syntax support
git clone https://github.com/altercation/vim-colors-solarized
git clone https://github.com/evidens/vim-twig
git clone https://github.com/tpope/vim-rails
#################################################



