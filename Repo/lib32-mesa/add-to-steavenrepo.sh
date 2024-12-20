#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp valve.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-mesa*x86_64.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-mesa*x86_64.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-opencl-clover-mesa*x86_64.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-opencl-clover-mesa*x86_64.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-opencl-rusticl-mesa*x86_64.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-opencl-rusticl-mesa*x86_64.pkg.tar.zst.sig
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-vulkan*x86_64.pkg.tar.zst
rm -rf /home/omarhanykasban/SteavenRepo/x86_64/lib32-vulkan*x86_64.pkg.tar.zst.sig
cp lib32-mesa*x86_64.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-mesa*x86_64.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-opencl-clover-mesa*x86_64.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-opencl-clover-mesa*x86_64.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-opencl-rusticl-mesa*x86_64.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-opencl-rusticl-mesa*x86_64.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-vulkan*x86_64.pkg.tar.zst /home/omarhanykasban/SteavenRepo/x86_64/
cp lib32-vulkan*x86_64.pkg.tar.zst.sig /home/omarhanykasban/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mesa               