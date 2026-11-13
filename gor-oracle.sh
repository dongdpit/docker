#!/bin/bash

sleep 5

CRS="/dev/sdb"
DBDISK="/dev/sdc"
FRA="/dev/sdd"

echo "**** Rescan disk ****"
echo
for host in /sys/class/scsi_host/*; do echo "- - -" | sudo tee $host/scan; ls /dev/sd* ; done

echo "**** Create new partition ****"
echo

printf "n\n\n\n\n\nw\ny\n" | gdisk $CRS
printf "n\n\n\n\n\nw\ny\n" | gdisk $DBDISK
printf "n\n\n\n\n\nw\ny\n" | gdisk $FRA

echo "**** Oracleasm createdisk ****"
echo
oracleasm createdisk CRS ${CRS}1
oracleasm createdisk DBDISK ${DBDISK}1
oracleasm createdisk FRA ${FRA}1

echo "**** Oracleasm scandisks ****"
echo
oracleasm scandisks
oracleasm listdisks

echo
echo "Finish"
