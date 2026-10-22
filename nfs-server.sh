#!/bin/bash

echo " _   _ ______  _____ "
echo "| \ | |  ____|/ ____|"
echo "|  \| | |__  | (___  "
echo "| . \` |  __|  \___ \ "
echo "| |\  | |     ____) |"
echo "|_| \_|_|    |_____/ "

sleep 5

NFS_SHARE="/home/nfsshare"

echo
echo "**** Update and Install NFS Server ****"
echo

apt update
apt -y install nfs-kernel-server

echo
echo "**** Configure NFS share ****"
echo

mkdir -p $NFS_SHARE

cat <<EOT>> /etc/exports
$NFS_SHARE x.x.x.x/24(rw,no_root_squash)
EOT

systemctl restart nfs-server

echo
echo "Finish install"
