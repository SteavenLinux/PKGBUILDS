#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp vlc-luajit/PKGBUILD ~/ah
cp vlc-luajit/add-ffmpeg7-support.patch ~/ah
cp vlc-luajit/taglib-2.patch ~/ah
cp vlc-luajit/update-vlc-plugin-cache.hook ~/ah
cp vlc-luajit/libnfs6-mr-6527.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/vlc-luajit*.pkg.tar.zst
rm -rf /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/vlc-luajit*.pkg.tar.zst.sig
cp vlc-luajit*.pkg.tar.zst /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/
cp vlc-luajit*.pkg.tar.zst.sig /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/SteavenRepo
git add .
git commit -m "Updated vlc-luajit"
cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/GitHub/Aur
