#!/usr/bin/env bash

# Install desktop environment
sudo apt install software-properties-common -y

# Needed for libxcb-xrm-dev, needed by i3wm
add-apt-repository ppa:aguignard/ppa -y
sudo apt update

# Install Xfce4
sudo apt install xubuntu-desktop gnome-terminal menu --no-install-recommends -y
sudo apt install gnome-terminal xfwm4-themes xfce4-terminal --no-install-recommends -y

sudo apt install build-essential cmake -y

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
sudo apt install cmake cmake-data libcairo2-dev libxcb1-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-image0-dev libxcb-randr0-dev libxcb-util0-dev libxcb-xkb-dev pkg-config python-xcbgen xcb-proto libxcb-xrm-dev i3-wm libasound2-dev libmpdclient-dev libiw-dev libcurl4-openssl-dev -y

if [[ ! -d "~/polybar" ]]; then
    git clone --branch 3.0.5 --recursive https://github.com/jaagr/polybar ~/polybar
else
    pushd ~/polybar
    git pull
    popd
fi

if [[ -d ~/polybar/build ]]; then
    rm -r ~/polybar/build
fi

mkdir ~/polybar/build
pushd ~/polybar/build
cmake ..
sudo make install
popd

mkdir -p ~/.config/polybar
cp -R ~/machines/home/.config/polybar ~/.config/polybar

mkdir -p ~/.config/i3
cp -R ~/machines/home/.config/i3 ~/.config/i3

cp ~/machines/home/.xinitrc ~
