#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp valve.patch
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/*mesa*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/*mesa*.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/vulkan*.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/vulkan*.pkg.tar.zst.sig
cp *mesa*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp *mesa*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/
cp vulkan*.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp vulkan*.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mesa                         
