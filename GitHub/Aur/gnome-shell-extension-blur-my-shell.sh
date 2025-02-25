#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp gnome-shell-extension-blur-my-shell/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/gnome-shell-extension-blur-my-shell*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/gnome-shell-extension-blur-my-shell*.pkg.tar.zst.sig
cp gnome-shell-extension-blur-my-shell*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp gnome-shell-extension-blur-my-shell*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated gnome-shell-extension-blur-my-shell"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur