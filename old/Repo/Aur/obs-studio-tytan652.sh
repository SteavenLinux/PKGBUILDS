#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp obs-studio-tytan652/PKGBUILD ~/ah
cp obs-studio-tytan652/bind_iface_eyeballed.patch ~/ah
cp obs-studio-tytan652/v4l2_by-path.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/nvme/SteavenRepo/x86_64/obs-studio-tytan652*.pkg.tar.zst
rm -rf /mnt/nvme/SteavenRepo/x86_64/obs-studio-tytan652*.pkg.tar.zst.sig
cp obs-studio-tytan652*.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64/
cp obs-studio-tytan652*.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/Aur
