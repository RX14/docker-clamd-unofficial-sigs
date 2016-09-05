#!/bin/bash
update_sigs() {
    echo
    echo
    echo "Running freshclam"
    freshclam

    echo
    echo
    echo "Running clamav-unofficial-sigs"
    /usr/local/bin/clamav-unofficial-sigs.sh --verbose
}

if [ ! -d "/data/clamav" ]; then
    mkdir /data/clamav 
    chown clamav:clamav /data/clamav
fi

if [ ! -d "/data/clamav-unofficial-sigs" ]; then
    mkdir /data/clamav-unofficial-sigs
    chown clamav:clamav /data/clamav-unofficial-sigs
fi

if [ ! "$(ls /data/clamav/)" ]; then
    echo "No databases detected: updating signatures for first-time run"

    prev_file=$(cat /etc/clamav-unofficial-sigs/os.conf)
    echo 'enable_random="no"' >> /etc/clamav-unofficial-sigs/os.conf
    update_sigs
    echo "$prev_file" > /etc/clamav-unofficial-sigs/os.conf
fi

(while true; do sleep 1h; update_sigs; done) &

echo
echo
echo "Starting clamd"
exec clamd
