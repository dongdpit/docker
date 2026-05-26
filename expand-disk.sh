#!/bin/bash

sleep 5

echo
echo "**** Rescan disk ****"
echo

echo 1>/sys/class/block/sda/device/rescan

echo
echo "**** Growpart device ****"
echo

growpart /dev/sda 3

echo
echo "**** Extend logical volume ****"
echo

lvextend -l +100%FREE -r /dev/mapper/ubuntu--vg-ubuntu--lv

echo
echo "Finish expand"
