#!/bin/bash
#rm -rf ~/ah-wine
cd wine-staging
mkdir ~/ah-wine
cp PKGBUILD ~/ah-wine
cp 30-win32-aliases.conf ~/ah-wine
cp wine-binfmt.conf ~/ah-wine
cp wine.install ~/ah-wine
cd ~/ah-wine
gpg --keyserver hkps://keyserver.ubuntu.com --recv-keys 5AC1A08B03BD7A313E0A955AF5E6E9EEB9461DD7 DA23579A74D4AD9AF9D3F945CEFAC8EAAF17519D

makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/wine-staging*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/wine-staging*.pkg.tar.zst.sig
cp wine-staging*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp wine-staging*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated wine-staging"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/wine-staging