#!/bin/bash
rm -rf ~/ah
mkdir ~/ah
cp PKGBUILD ~/ah
cp valve.patch ~/ah
cd ~/ah
makepkg -sr --sign
rm -rf /mnt/nvme/SteavenRepo/x86_64/mesa*x86_64.pkg.tar.zst
rm -rf /mnt/nvme/SteavenRepo/x86_64/mesa*x86_64.pkg.tar.zst.sig
rm -rf /mnt/nvme/SteavenRepo/x86_64/opencl-clover-mesa*x86_64.pkg.tar.zst
rm -rf /mnt/nvme/SteavenRepo/x86_64/opencl-clover-mesa*x86_64.pkg.tar.zst.sig
rm -rf /mnt/nvme/SteavenRepo/x86_64/opencl-rusticl-mesa*x86_64.pkg.tar.zst
rm -rf /mnt/nvme/SteavenRepo/x86_64/opencl-rusticl-mesa*x86_64.pkg.tar.zst.sig
rm -rf /mnt/nvme/SteavenRepo/x86_64/vulkan*x86_64.pkg.tar.zst
rm -rf /mnt/nvme/SteavenRepo/x86_64/vulkan*x86_64.pkg.tar.zst.sig
cp mesa*x86_64.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64/
cp mesa*x86_64.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64/
cp opencl-clover-mesa*x86_64.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64/
cp opencl-clover-mesa*x86_64.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64/
cp opencl-rusticl-mesa*x86_64.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64/
cp opencl-rusticl-mesa*x86_64.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64/
cp vulkan*x86_64.pkg.tar.zst /mnt/nvme/SteavenRepo/x86_64/
cp vulkan*x86_64.pkg.tar.zst.sig /mnt/nvme/SteavenRepo/x86_64/

cd /home/omarhanykasban/GitHub/SteavenLinux/PKGBUILDS/Repo/mesa               