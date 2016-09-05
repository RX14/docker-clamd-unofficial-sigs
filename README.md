# docker-clamd-unofficial-sigs

This container runs a `clamd` server on port 3310. `freshclam` and `clamav-unofficial-sigs.sh` are run hourly.

## Instructions

1. Download `user.conf` from [here](https://github.com/extremeshok/clamav-unofficial-sigs/blob/master/config/user.conf) and set your malwarepatrol and securiteinfo registration details. Make sure you set `user_configuration_complete="yes"`
2. Create a directory to store data for clamav. Set the permissions to `777`. Directories with the correct permissions will be created underneath.
3. Run `docker run -i -v /path/to/data/dir:/data -v /path/to/user.conf:/etc/clamav-unofficial-sigs/user.conf rx14/clamd-unofficial-sigs` and wait for the first database download and clamd to start.
4. Shut down the container in 3, and run the container however you wish. Make sure you specify the correct volumes, however you create the container.
5. Use the clamd protocol over port 3310.
