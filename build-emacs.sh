#!/usr/bin/env bash

# Building Emacs 30 pgtk for Wayland with native compilation on Arch Linux 

# Install necessary dependencies
sudo pacman -S --needed libgccjit git gtk3 xorg-xwayland libxpm libjpeg-turbo libpng libtiff giflib librsvg gnutls autoconf libmpc texinfo ncurses libxml2 harfbuzz jansson libfm-gtk3 imagemagick tree-sitter

# Clone Emacs repository
git clone --depth 1 git://git.sv.gnu.org/emacs.git ~/downloads/emacs
cd ~/downloads/emacs

# Set CC and CXX environment variables to inform the Emacs configuration script as to the location of gcc, otherwise it fails to find libgccjit
export CC=/usr/bin/gcc
export CXX=/usr/bin/gcc

# Configure and build Emacs
./autogen.sh
./configure --prefix=/usr/local --with-native-compilation --with-pgtk --with-dbus --with-gif --with-jpeg --with-png --with-rsvg --with-tiff --with-xft --with-xpm --with-gpm=no --with-imagemagick --with-json --with-xwidgets --with-modules --without-pop
make -j$(nproc)
sudo make install

# Move Emacs installation
cd - && sudo mv ~/downloads/emacs/ /opt

# Copy desktop files
sudo cp /usr/local/share/applications/* ~/.local/share/applications/

# Informational message
echo 'Change the following line to ~/.local/share/applications/emacsclient.desktop:'
echo 'Exec=/usr/local/bin/emacsclient -c %F'

# Unsure
#mv ~/.config/emacs/eln-cache ~/desktop
#mv ~/.config/emacs/transient ~/desktop
