#!/usr/bin/env bash

# Install desktop environment
sudo apt install software-properties-common -y

# Needed for libxcb-xrm-dev, needed by i3wm
sudo add-apt-repository ppa:aguignard/ppa -y
sudo apt update

# Install Xfce4
sudo apt install xubuntu-desktop gnome-terminal menu --no-install-recommends -y
sudo apt install gnome-terminal xfwm4-themes xfce4-terminal --no-install-recommends -y

sudo apt install build-essential curl -y

# Dependencies for i3-gaps
sudo apt install libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm-dev libxcb-xrm-dev -y

# Get i3-gaps
if [[ ! -d ~/i3-gaps ]]; then
    git clone https://www.github.com/Airblader/i3 ~/i3-gaps
else
    pushd ~/i3-gaps
    git pull
    popd
fi

pushd ~/i3-gaps
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

popd

# polybar
sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev -y

if [[ ! -d ~/polybar ]]; then
    git clone --branch 3.0.5 --recursive https://github.com/jaagr/polybar ~/polybar
else
    pushd ~/polybar
    git pull
    popd
fi

# if [[ -d ~/polybar/build ]]; then
#     rm -rf ~/polybar/build
# fi

mkdir -p ~/polybar/build
pushd ~/polybar/build
cmake ..
sudo make install
popd

# Arc Theme
sudo apt install libgtk-3-dev gnome-themes-standard gkt2-engines-murrine -y

if [[ ! -d ~/arc-theme ]]; then
    git clone https://github.com/horst3180/arc-theme --depth 1
else
    pushd ~/arc-theme
    git pull
    popd
fi

pushd ~/arc-theme
./autogen.sh --prefix=/usr
sudo make install
popd

# Download fonts
mkdir -p ~/.local/share/fonts

pushd ~/.local/share/fonts
curl -fLo "DejaVu Sans Mono Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/DejaVuSansMono/Regular/complete/DejaVu%20Sans%20Mono%20Nerd%20Font%20Complete%20Mono.ttf?raw=true
popd

# dotfiles
if [[ ! -d ~/dotfiles ]]; then
    git clone --recursive https://github.com/joakimkarlsson/dotfiles.git
else
    pushd ~/dotfiles
    git pull
    popd
fi

sudo apt install zsh vim-nox silversearcher-ag -y

ln -s ~/dotfiles/.config/base16-shell ~/.config
ln -s ~/dotfiles/.vim ~
ln -s ~/dotfiles/.zshfunctions ~
ln -s ~/.ctags ~
ln -s ~/.tmux.conf ~
ln -s ~/.tmuxline.conf ~
ln -s ~/.vimrc ~
ln -s ~/.zshrc ~



# Sync configuration files
rsync -r ~/machines/home/.config ~/

rm -rf ~/.cache/sessions
