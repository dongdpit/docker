#!/bin/bash

echo " _   _ ______  _____ "
echo "| \ | |  ____|/ ____|"
echo "|  \| | |__  | (___  "
echo "| . \` |  __|  \___ \ "
echo "| |\  | |     ____) |"
echo "|_| \_|_|    |_____/ "

sleep 5

NFS_SERVER=""
NFS_SHARE="/home/nfsshare"
MOUNT_POINT="/mnt"

echo
echo "**** Update and Install NFS Client ****"
echo

apt update
apt -y install nfs-common

echo
echo "**** Mount NFS share ****"
echo

if ! grep -q "$MOUNT_POINT" /etc/fstab; then
    echo "$NFS_SERVER:$NFS_SHARE $MOUNT_POINT  nfs  defaults  0 1" | sudo tee -a /etc/fstab
fi
mount -a

echo
echo "Finish install"
