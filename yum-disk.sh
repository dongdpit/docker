#!/bin/bash

sleep 5

echo
echo "**** Rescan disk ****"
echo

echo 1>/sys/class/block/sda/device/rescan

echo
echo "**** Growpart device ****"
echo

parted -s /dev/sda resizepart 2 100%
partprobe /dev/sda

echo
echo "**** Resize PV ****"
echo

pvresize /dev/sda2

echo
echo "**** Extend resize logical volume ****"
echo

lvextend -l +100%FREE -r /dev/mapper/ol-root

echo
echo "Finish expand"
