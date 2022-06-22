#!/usr/bin/env sh

sh <(curl -L https://nixos.org/nix/install)

nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
nix-channel --update

# let nix-darwin handle /etc/nix/nix.conf
sudo mv /etc/nix/nix.conf /etc/nix/.nix-darwin.bkp.nix.conf

# install nix-darwin
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer

chsh -s /run/current-system/sw/bin/fish

if [ ! -d "$HOME/.config/doom" ]; then
  mkdir -p $HOME/.config
  git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
  git clone https://github.com/schrenker/doom.d.git ~/.config/doom
fi

echo "Reload shell to activate fish and run commands:"
echo
echo "For creating environment:"
echo 'darwin-rebuild switch'
echo
echo "For doom installation:"
echo 'doom install'
