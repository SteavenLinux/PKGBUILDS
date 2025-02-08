#!/bin/bash

VERSION="3.16.1.r39.gbafa157-1"

rm -rf ~/ah
mkdir ~/ah
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/gamescope-git-${VERSION}-x86_64.pkg.tar.zst"
cd ~/ah
gpg --detach-sign --use-agent --output "gamescope-git-${VERSION}-x86_64.pkg.tar.zst.sig" "gamescope-git-${VERSION}-x86_64.pkg.tar.zst"
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/gamescope-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/gamescope-git*.pkg.tar.zst.sig
cp gamescope-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp gamescope-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated gamescope-git"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Choatic-Aur
