#!/bin/sh

case "$1" in
    "libvirt")
        echo "Updating libvirtd.conf..."
        sed -i 's|#unix_sock_group = "libvirt"|unix_sock_group = "libvirt"|' /etc/libvirt/libvirtd.conf
        sed -i 's|#unix_sock_rw_perms = "0770"|unix_sock_rw_perms = "0770"|' /etc/libvirt/libvirtd.conf
        ;;
    "qemu")
        echo "Updating qemu.conf..."
        sed -i '/^#cgroup_device_acl = \[/,/^#\]/ s/^#//g' /etc/libvirt/qemu.conf
        sed -i 's|\("/dev/userfaultfd"\)|\1, "/dev/kvmfr0"|' /etc/libvirt/qemu.conf
        ;;
    *)
        echo "Usage: $0 {libvirt|qemu}"
        exit 1
        ;;
esac

# Restart libvirtd to apply changes
systemctl restart libvirtd
