## terminal programs
sudo apt install vim-gtk3 vifm tmux
sudo apt install urlview xsel xclip rg fzf fd-find exiftool

## gui programs
sudo apt install xterm firefox flameshot thunderbird keepassxc zathura feh codium qbittorent

## programming tools/environments setup

### nodejs setup
sudo apt install -y build-essential git
sudo apt install -y nodejs npm
npm config set prefix ~/.local
npm install -g n
n lts

### python setup
sudo apt install -y python3-pip

## general
### dragon
sudo apt-get install libgtk-3-dev # to compile dragon, can later rm
git clone https://github.com/mwh/dragon
cd dragon
make
make install
cd ..
rm -r dragon
