#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp gnome-shell-extension-alphabetical-grid-extension/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/gnome-shell-extension-alphabetical-grid-extension*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/gnome-shell-extension-alphabetical-grid-extension*.pkg.tar.zst.sig
cp gnome-shell-extension-alphabetical-grid-extension*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp gnome-shell-extension-alphabetical-grid-extension*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated gnome-shell-extension-alphabetical-grid-extension"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur