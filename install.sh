#!/bin/sh

# Ask for the administrator password upfront
sudo -v

loading () {
  for (( i = 1; i <= $1; i ++)); do
    printf "."
    sleep 0.05
  done
  echo -e "\n\n"
}

# Color variables
GREEN='\033[32m'
NC='\033[0m'
BLUE='\033[36m'


echo "###################################################"
echo "#                                                 #"
echo "#      You are about to setup this computer       #"
echo "#                  lets do it                     #"
echo "#                                                 #"
echo -e "###################################################\n\n"

echo "Press any key to conitnue or 'q' to exit"

while : ; do
  read -n 1 k <&1
  if [[ $k = q ]] ; then
    printf "\nQuitting\n"
    exit
  else
    printf "\n\n${GREEN}Starting the sequence${NC}\n"
    break
  fi
done

loading 20

echo "Installing Homebrew ..............................."
loading 10
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo -e "${GREEN}Homebrew installed${NC}"
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Installing Composer ..............................."
loading 10
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
echo -e "${GREEN}Composer Installed${NC}"
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Creating ~/Repos folder ..........................."
loading 10
if [ ! -d ~/Repos ]; then
  mkdir ~/Repos
  echo -e "${GREEN}Repos folder created${NC}"
else
  echo -e "${GREEN}Repos folder already exist${NC}"
fi
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Creating simlink .................................."
loading 10
DOTFILES=$HOME/dotfiles/tolink
for file in $(ls $DOTFILES); do
  if [ ! -L "${HOME}/.$file" ]; then
    ln -s $DOTFILES/$file $HOME/.$file
    echo -e "${GREEN}${file} linked${NC}"
  fi
done
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"

echo "Installing fonts .................................."
loading 10
SOURCEFONTS="$HOME/dotfiles/resources/fonts"
TARGETFONTS="$HOME/Library/Fonts"
for font in $(ls $SOURCEFONTS); do
  if [ ! -e "${TARGETFONTS}/${font}" ]; then
    cp $SOURCEFONTS/$font $TARGETFONTS/$font
    echo -e "${GREEN}${font} installed${NC}"
  fi
done
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Installing node and npm ..........................."
loading 10
brew install node
echo -e "${GREEN}Node and npm installed${NC}"
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Installing gulp ..................................."
loading 10
sudo shown $USER /usr/local/lib/node_modules
npm install gulp-cli -g
echo -e "${GREEN}Gulp installed${NC}"
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Creating SSH key .................................."
loading 10
read -e -p "Please enter your desired SSH passphrase (leave blank for none): " sshpassphrase
ssh-keygen -t rsa -N sshpassphrase -f temp_key
mv temp_key ~/.ssh/id_rsa
mv temp_key.pub ~/.ssh/id_rsa.pub
echo -e "${GREEN}SSH created${NC}"
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


# echo "Installing Vundle ................................."
# loading 10
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# vim +PluginInstall +qall
# echo -e "${GREEN}Vundle installed${NC}"
# echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"


echo "Installing softwares .............................."
loading 10
bash ./brew.sh
echo -e "${GREEN}Softwares installed${NC}"
echo -e "-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n\n"



echo -e "${BLUE}   _   _ _       _                                        _"
echo "  /_\ | | |   __| | ___  _ __   ___   _ __ ___   __ _ ___| |_ ___ _ __"
echo " //_\\\\| | |  / _\` |/ _ \| '_ \ / _ \ | '_ \` _ \ / _\` / __| __/ _ \ '__|"
echo "/  _  \ | | | (_| | (_) | | | |  __/ | | | | | | (_| \__ \ ||  __/ |"
echo -e "\_/ \_/_|_|  \__,_|\___/|_| |_|\___| |_| |_| |_|\__,_|___/\__\___|_|${NC}"

echo "\n\n\n"
echo "enter 'relaod' to relaod the shell"
