#!/bin/bash

sleep 5

DEVICE="/dev/sdb"
VG_NAME="mongo-vg"
LV_NAME="mongo-lv"
MOUNT_POINT="/database"

echo "**** Rescan disk ****"
echo
for host in /sys/class/scsi_host/*; do echo "- - -" | sudo tee $host/scan; ls /dev/sd* ; done

echo "**** Create new partition ****"
echo
printf "n\np\n\n\n\nw\n" | fdisk $DEVICE

echo "**** Create PV ****"
echo
pvcreate ${DEVICE}1

echo "**** Create VG ****"
echo
vgcreate $VG_NAME ${DEVICE}1

echo "**** Create LV ****"
echo
lvcreate -l 100%FREE -n $LV_NAME $VG_NAME

echo "**** Format ****"
echo
mkfs.ext4 /dev/$VG_NAME/$LV_NAME
mkdir -p $MOUNT_POINT

echo "**** Mount ****"
echo
if ! grep -q "$MOUNT_POINT" /etc/fstab; then
    echo "/dev/$VG_NAME/$LV_NAME  $MOUNT_POINT  ext4  defaults  0 1" | sudo tee -a /etc/fstab
fi
mount -a

echo
echo "Finish"
