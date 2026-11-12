#!/bin/bash

sleep 5

DEVICE="/dev/sda"
PARTITION="/dev/sda4"
MOUNT_POINT="/u01"
FS_TYPE="xfs"

echo
echo "**** Rescan disk ****"
echo

echo 1 > /sys/class/block/sda/device/rescan

echo "**** Create partition sda4 ****"
if lsblk | grep -q "sda4"; then
    echo "sda4 exists. Skip."
else
    printf "n\n\n\n\n\nw\ny\ny\n" | gdisk $DEVICE
    partprobe $DEVICE
    sleep 2
fi

echo "**** Format ****"
if lsblk -f | grep -q "sda4.*$FS_TYPE"; then
    echo "sda4 formated $FS_TYPE. Skip."
else
    mkfs.$FS_TYPE $PARTITION
fi

echo "**** Mount ****"
mkdir -p $MOUNT_POINT

echo
if ! grep -q "$MOUNT_POINT" /etc/fstab; then
    UUID=$(blkid -s UUID -o value $PARTITION)
    echo "UUID=$UUID  $MOUNT_POINT  $FS_TYPE  defaults  0 0" | sudo tee -a /etc/fstab
fi
mount -a

echo
echo "Finish"
