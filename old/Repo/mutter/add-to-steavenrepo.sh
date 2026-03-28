#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp mr1441.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/mutter*.pkg.tar.zst
rm -rf /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/mutter*.pkg.tar.zst.sig
cp mutter*.pkg.tar.zst /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/
cp mutter*.pkg.tar.zst.sig /mnt/Omar-PC-Server/home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mutter
