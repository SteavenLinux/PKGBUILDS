#!/bin/bash

VERSION="6.13.1-1"
VERSIONLTS="6.12.11-1"

rm -rf ~/ah
mkdir ~/ah
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/linux-vfio-${VERSION}-x86_64.pkg.tar.zst"
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/linux-vfio-headers-${VERSION}-x86_64.pkg.tar.zst"
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/linux-vfio-lts-${VERSIONLTS}-x86_64.pkg.tar.zst"
wget -P ~/ah "https://de-2-mirror.chaotic.cx/chaotic-aur/x86_64/linux-vfio-lts-headers-${VERSIONLTS}-x86_64.pkg.tar.zst"

cd ~/ah
gpg --detach-sign --use-agent --output "linux-vfio-${VERSION}-x86_64.pkg.tar.zst.sig" "linux-vfio-${VERSION}-x86_64.pkg.tar.zst"
gpg --detach-sign --use-agent --output "linux-vfio-headers-${VERSION}-x86_64.pkg.tar.zst.sig" "linux-vfio-headers-${VERSION}-x86_64.pkg.tar.zst"
gpg --detach-sign --use-agent --output "linux-vfio-lts-${VERSIONLTS}-x86_64.pkg.tar.zst.sig" "linux-vfio-lts-${VERSIONLTS}-x86_64.pkg.tar.zst"
gpg --detach-sign --use-agent --output "linux-vfio-lts-headers-${VERSIONLTS}-x86_64.pkg.tar.zst.sig" "linux-vfio-lts-headers-${VERSIONLTS}-x86_64.pkg.tar.zst"
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/linux-vfio*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/linux-vfio*.pkg.tar.zst.sig
cp linux-vfio*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp linux-vfio*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Choatic-Aur
