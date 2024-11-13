#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp chatterino2-appimage/PKGBUILD ~/ah
cp chatterino2-appimage/Makefile ~/ah
cp chatterino2-appimage/chatterino2-appimage.install ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/chatterino2-appimage*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/chatterino2-appimage*.pkg.tar.zst.sig
cp chatterino2-appimage*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp chatterino2-appimage*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated chatterino2-appimage"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur