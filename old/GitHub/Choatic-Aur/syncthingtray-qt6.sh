#!/bin/bash

VERSION="1.7.2-1"

rm -rf ~/ah
mkdir ~/ah
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/syncthingtray-qt6-${VERSION}-x86_64.pkg.tar.zst"
cd ~/ah
gpg --detach-sign --use-agent --output "syncthingtray-qt6-${VERSION}-x86_64.pkg.tar.zst.sig" "syncthingtray-qt6-${VERSION}-x86_64.pkg.tar.zst"
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/syncthingtray-qt6*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/syncthingtray-qt6*.pkg.tar.zst.sig
cp syncthingtray-qt6*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp syncthingtray-qt6*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated syncthingtray-qt6"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Choatic-Aur
