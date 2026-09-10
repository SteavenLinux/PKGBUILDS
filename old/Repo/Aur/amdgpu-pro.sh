#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp amdgpu-pro/PKGBUILD ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/hdd/SteavenRepo/x86_64/*amdgpu-pro*.pkg.tar.zst
rm -rf /mnt/hdd/SteavenRepo/x86_64/*amdgpu-pro*.pkg.tar.zst.sig
cp *amdgpu-pro*.pkg.tar.zst /mnt/hdd/SteavenRepo/x86_64/
cp *amdgpu-pro*.pkg.tar.zst.sig /mnt/hdd/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur