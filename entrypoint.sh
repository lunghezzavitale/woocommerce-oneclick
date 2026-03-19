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

# Run setup in background after a delay
(sleep 10 && run_setup) &

# Run the original WordPress entrypoint
exec docker-entrypoint.sh "$@"
