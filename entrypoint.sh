#!/bin/bash

# Run setup script after WordPress is ready
run_setup() {
    # Wait for WordPress files to be ready
    while [ ! -d /var/www/html/wp-content/plugins ]; do
        sleep 2
    done

    # Run the setup script
    /usr/local/bin/setup-wordpress.sh
}

# Write a static health check file that Apache serves directly,
# bypassing WordPress routing/redirects so Railway's healthcheck always gets a 200.
echo "OK" > /var/www/html/healthz.html

# Run setup in background after a delay
(sleep 10 && run_setup) &

# Run the original WordPress entrypoint
exec docker-entrypoint.sh "$@"
