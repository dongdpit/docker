#!/bin/bash

sleep 5

ADISK="/dev/sdb"
DBDISK="/dev/sdc"
FDISK="/dev/sdd"
VDISK="/dev/sde"

echo "**** Rescan disk ****"
echo
for host in /sys/class/scsi_host/*; do echo "- - -" | sudo tee $host/scan; ls /dev/sd* ; done

echo "**** Create new partition ****"
echo
printf "n\np\n\n\n\nw\n" | fdisk $ADISK
printf "n\np\n\n\n\nw\n" | fdisk $DBDISK
printf "n\np\n\n\n\nw\n" | fdisk $FDISK
printf "n\np\n\n\n\nw\n" | fdisk $VDISK

echo "**** Oracleasm createdisk ****"
echo
oracleasm createdisk ADISK ${ADISK}1
oracleasm createdisk DBDISK ${DBDISK}1
oracleasm createdisk FDISK ${FDISK}1
oracleasm createdisk VDISK ${VDISK}1

echo "**** Oracleasm scandisks ****"
echo
oracleasm scandisks
oracleasm listdisks

echo
echo "Finish"
