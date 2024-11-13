#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp heroic-games-launcher-bin/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/heroic-games-launcher-bin*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/heroic-games-launcher-bin*.pkg.tar.zst.sig
cp heroic-games-launcher-bin*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp heroic-games-launcher-bin*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur