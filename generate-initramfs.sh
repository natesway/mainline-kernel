#!/bin/bash

# Needs to run after building the kernel for the first time

# File naming
case $1 in
  stable)
  MODULES="modules-stable.tar.xz"
  VMLINUZ="bzImage-stable"
  CONFIG="config-stable"
  INITRAMFS="initramfs-stable.img"
  ;;
  testing)
  MODULES="modules-testing.tar.xz"
  VMLINUZ="bzImage-testing"
  CONFIG="config-testing"
  INITRAMFS="initramfs-testing.img"
  ;;
esac

rm /boot/*
cp $VMLINUZ /boot/vmlinuz-eupnea
tar xf $MODULES -C /lib/modules/

sudo apt install dracut

dracut $INITRAMFS

rm */.config

sed -i "s/CONFIG_INITRAMFS_SOURCE=\"\"/CONFIG_INITRAMFS_SOURCE=\"$INITRAMFS\"/g" $CONFIG
