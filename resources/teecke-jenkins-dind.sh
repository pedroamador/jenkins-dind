#!/bin/bash -e

# Start docker in the background
/usr/local/bin/dockerd-entrypoint.sh &

# Enable the docker daemon for jenkins user access
sleep 5
chmod 666 /var/run/docker.sock

# Start jenkins in the background
sudo -u jenkins bash -c "/sbin/tini -- /usr/local/bin/jenkins.sh $@" &

# Container main proccess. Allow docker & jenkins processes to be restarted
tail -f /dev/null