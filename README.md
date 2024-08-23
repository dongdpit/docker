# docker
-------------
FIX BUG error response from daemon
-------------
cat <<EOT>> /etc/docker/daemon.json

{

"debug": true

}

EOT
