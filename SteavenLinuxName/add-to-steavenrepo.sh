#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp logo.png ~/ah
cp logo.svg ~/ah
cp lsb-release.hook ~/ah
cp os-release.hook ~/ah
cp steavenlinux-hooks-runner ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/steavenlinuxname*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/steavenlinuxname*.pkg.tar.zst.sig
cp steavenlinuxname*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp steavenlinuxname*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated steavenlinuxname"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/steavenlinuxname