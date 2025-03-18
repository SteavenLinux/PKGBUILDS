#!/bin/bash
#rm -rf ~/ah
mkdir ~/ah
cp davinci-resolve-studio/PKGBUILD ~/ah
cp davinci-resolve-studio/davinci-resolve-studio.install ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/*davinci-resolve-studio*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/*davinci-resolve-studio*.pkg.tar.zst.sig
cp *davinci-resolve-studio*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp *davinci-resolve-studio*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur
