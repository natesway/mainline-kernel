#!/bin/bash
# Generates an initramfs using an alpine image and custom scripts

# Exit on errors
set -e

ALPINE_URL="https://dl-cdn.alpinelinux.org/alpine/v3.16/releases/x86_64/alpine-minirootfs-3.16.2-x86_64.tar.gz"
WORKING_DIR=$(pwd)
INITFS_DIR=$WORKING_DIR/initramfs

# Setup a minimal alpine rootfs
rm -rf $INITFS_DIR
mkdir -p $INITFS_DIR
cd $INITFS_DIR
wget $ALPINE_URL
tar -xf alpine*
rm -f alpine*

# Replace the init with a custom script
rm -f sbin/init
install -Dt sbin/ -m 755 $WORKING_DIR/init
