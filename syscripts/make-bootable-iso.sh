#!/bin/bash

if [ $# -gt 2 ] || [ $# -eq 2 ]; then
    echo "[!] Positional params 1) iso location 2) device addr"
    echo "[!] Usage ~> make-bootable-iso.sh ./my-iso.iso /dev/sda1"
    exit 1
fi

iso_location=$1
device=$1

if [ ! -x $iso_location ]; then
    echo "[!] ISO image not found.";
    exit 1
fi

echo "[!] Copying iso to usb ..."
dd if=$iso_location of=$device bs=1048576
echo "[!] Done."
