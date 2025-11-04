#!/bin/bash

sleep 5

echo
echo "**** Rescan disk ****"
echo

for host in /sys/class/scsi_host/*; do echo "- - -" | sudo tee $host/scan; ls /dev/sd* ; done

echo
echo "**** Create physical volume ****"
echo

pvcreate /dev/sdn

echo
echo "**** Extend volume group ****"
echo

vgextend ol /dev/sdn
 
echo
echo "**** Extend swap size ****"
echo

lvextend -l +100%FREE /dev/mapper/ol-swap

echo
echo "**** Reactive swap ****"
echo

swapoff -a
mkswap /dev/mapper/ol-swap
swapon -a

echo
echo "**** Show swap ****"
echo

swapon --show
free -h
