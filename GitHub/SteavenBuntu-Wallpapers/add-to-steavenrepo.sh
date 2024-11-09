#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp ah.jpg ~/ah
cp hream.jpg ~/ah
cp Steaven-wallpaper.jpg ~/ah
cp windows7.jpg ~/ah
cp wallpapers.xml ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/SteavenBuntu-Wallpapers*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/SteavenBuntu-Wallpapers*.pkg.tar.zst.sig
cp SteavenBuntu-Wallpapers*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp SteavenBuntu-Wallpapers*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated SteavenBuntu-Wallpapers"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/SteavenBuntu-Wallpapers
