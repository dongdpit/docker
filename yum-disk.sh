#!/bin/bash

sleep 5

echo
echo "**** Rescan disk ****"
echo

echo 1>/sys/class/block/sda/device/rescan

echo
echo "**** Growpart device ****"
echo

printf "resizepart 2 100%\nquit\n" | parted /dev/sda 2

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
