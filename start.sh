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

mkdir /data/clamav
chown clamav:clamav /data/clamav
mkdir /data/clamav-unofficial-sigs
chown clamav:clamav /data/clamav-unofficial-sigs

if [ ! "$(ls /data/clamav/)" ]; then
    echo "No databases detected: updating signatures for first-time run"
    update_sigs
fi

(while true; do sleep 1h; update_sigs; done) &

echo
echo
echo "Starting clamd"
exec clamd
