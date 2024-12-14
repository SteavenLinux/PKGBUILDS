#!/bin/bash

VERSION="0.7.2.r110.g24d3cd9-1"

rm -rf ~/ah
mkdir ~/ah
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/mangohud-git-${VERSION}-x86_64.pkg.tar.zst"
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/lib32-mangohud-git-${VERSION}-x86_64.pkg.tar.zst"
cd ~/ah
gpg --detach-sign --use-agent --output "mangohud-git-${VERSION}-x86_64.pkg.tar.zst.sig" "mangohud-git-${VERSION}-x86_64.pkg.tar.zst"
gpg --detach-sign --use-agent --output "lib32-mangohud-git-${VERSION}-x86_64.pkg.tar.zst.sig" "mangohud-git-${VERSION}-x86_64.pkg.tar.zst"
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/mangohud-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/mangohud-git*.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/lib32-mangohud-git*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/lib32-mangohud-git*.pkg.tar.zst.sig
cp mangohud-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp mangohud-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp lib32-mangohud-git*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp lib32-mangohud-git*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated mangohud-git"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Choatic-Aur
