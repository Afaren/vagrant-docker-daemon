#!/bin/bash

echo "make docker.service.d"
mkdir -p /etc/systemd/system/docker.service.d

# configuration
dockerConfigFile="/etc/systemd/system/docker.service.d/options.conf"
dockerDaemonPort="2375"

# --------------------------------------------------------
# Function for creating log entries on the console
# --------------------------------------------------------
# $1 - Log level
# $2 - Log text
# --------------------------------------------------------
function log() {

    # read parameters
    local level="$1"
    local text="$2"

    # create log message
    local now=$(date +"%d-%m-%Y %H:%M:%S")
    echo -e "\n$now [$level] $text\n"
}

# allow connections to docker socket from the outside world
# solution from https://dockerlabs.collabnix.com/beginners/components/daemon/access-daemon-externally.html
echo '[Service]'  >> "$dockerConfigFile"
echo 'ExecStart=' >> "$dockerConfigFile"
echo "ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:$dockerDaemonPort" >> "$dockerConfigFile"

# restart docker daemon
systemctl daemon-reload
systemctl restart docker

# get current ip address
ipAddress="$(hostname -I | cut -d' ' -f2)"

# get docker host variable
dockerHost="tcp://$ipAddress:$dockerDaemonPort"

# log docker host variable usage
if [ "$HOST_IS_WINDOWS" == "true" ]
then
    dockerHostVariableString="set DOCKER_HOST=$dockerHost"
else
    dockerHostVariableString="export DOCKER_HOST=$dockerHost"
fi  

log "INFO" "Set environment variable to connect to docker daemon: $dockerHostVariableString"  