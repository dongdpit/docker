#!/bin/bash

echo  " __                 _               "
echo  "| |\ \  ___     ___| | __ ___ _ __  "
echo  "| || | / _ \  //   | |/ /   _ \ '__|"
echo  "| |/ /| (_) |||    |  < |  __/ |    "
echo  "|_|_/  \___/  \\___|_|_\_\___|_|    "

sleep 5

echo 
echo "**** Update repository package and Install Docker ****"
echo 

apt update
apt install -y ca-certificates curl apt-transport-https
curl -fsSL https://get.docker.com | bash

systemctl enable --now docker

echo 
echo "**** Configure Docker proxy ****"
echo 

mkdir -p /etc/systemd/system/docker.service.d

cat <<EOT>> /etc/systemd/system/docker.service.d/http-proxy.conf
[Service]
Environment="HTTP_PROXY="
Environment="HTTPS_PROXY="
Environment="NO_PROXY=10.0.0.0/8,169.254.0.0/16,172.16.0.0/12,192.168.0.0/16,127.0.0.0/8,localhost"
EOT

systemctl daemon-reload
systemctl restart docker

echo 
echo "Finish install"
