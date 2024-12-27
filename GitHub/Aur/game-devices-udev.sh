#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp game-devices-udev/PKGBUILD ~/ah
cp game-devices-udev/uinput.conf ~/ah
cp game-devices-udev/install ~/ah
cp -r game-devices-udev/keys ~/ah/keys
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/game-devices-udev*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/game-devices-udev*.pkg.tar.zst.sig
cp game-devices-udev*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp game-devices-udev*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated game-devices-udev"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur
