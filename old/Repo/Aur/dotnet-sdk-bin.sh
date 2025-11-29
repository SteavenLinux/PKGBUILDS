#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp dotnet-sdk-bin/PKGBUILD ~/ah
cp dotnet-sdk-bin/dotnet.sh ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/dotnet-sdk-bin*.pkg.tar.zst
rm -rf /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/dotnet-sdk-bin*.pkg.tar.zst.sig
cp dotnet-sdk-bin*.pkg.tar.zst /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/
cp dotnet-sdk-bin*.pkg.tar.zst.sig /mnt/Omar-Old-PC/home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur
