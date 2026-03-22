#!/bin/bash
# Don't use set -e so script continues even if some commands fail

# Change to WordPress directory
cd /var/www/html

# Wait for wp-config.php to exist (created by docker-entrypoint)
echo "Waiting for WordPress configuration..."
while [ ! -f /var/www/html/wp-config.php ]; do
  sleep 2
done

# Wait for database to be ready
echo "Waiting for database connection..."
for i in $(seq 1 30); do
  if wp db check --allow-root 2>/dev/null; then
    echo "Database connected!"
    break
  fi
  echo "Database not ready, attempt $i/30..."
  sleep 3
done

# Check if WordPress is already installed
if ! wp core is-installed --allow-root 2>/dev/null; then
  # Check if required admin credentials are provided
  if [ -z "${WORDPRESS_ADMIN_USER}" ] || [ -z "${WORDPRESS_ADMIN_PASSWORD}" ] || [ -z "${WORDPRESS_ADMIN_EMAIL}" ]; then
    echo "Admin credentials not provided. Please complete WordPress setup via the setup wizard."
    echo "Visit your site URL to begin the installation process."
    exit 0
  else
    echo "Installing WordPress..."
    
    wp core install \
      --url="${WORDPRESS_URL:-http://localhost}" \
      --title="${WORDPRESS_TITLE:-My WooCommerce Site}" \
      --admin_user="${WORDPRESS_ADMIN_USER}" \
      --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
      --admin_email="${WORDPRESS_ADMIN_EMAIL}" \
      --skip-email \
      --allow-root

    echo "WordPress installed successfully!"
  fi
fi

# Set permalink structure to post name (required for WooCommerce)
echo "Setting permalink structure..."
wp rewrite structure '/%postname%/' --allow-root
wp rewrite flush --allow-root

# Remove default plugins (keep only next-revalidate)
echo "Removing default plugins..."
wp plugin delete akismet --allow-root 2>/dev/null || true
wp plugin delete hello --allow-root 2>/dev/null || true

# Install and activate WooCommerce
if ! wp plugin is-active woocommerce --allow-root 2>/dev/null; then
  echo "Installing WooCommerce (this may take a minute)..."
  for i in 1 2 3; do
    wp plugin install woocommerce --activate --allow-root && break
    echo "WooCommerce install attempt $i failed, retrying..."
    sleep 5
  done
  if wp plugin is-active woocommerce --allow-root 2>/dev/null; then
    echo "WooCommerce installed and activated!"
  else
    echo "WARNING: WooCommerce installation failed. Please install manually from wp-admin."
  fi
fi

# Install and activate Storefront theme if not already installed
if ! wp theme is-installed storefront --allow-root 2>/dev/null; then
  echo "Installing Storefront theme..."
  wp theme install storefront --activate --allow-root
  echo "Storefront theme installed and activated!"
elif ! wp theme is-active storefront --allow-root 2>/dev/null; then
  echo "Activating Storefront theme..."
  wp theme activate storefront --allow-root
  echo "Storefront theme activated!"
else
  echo "Storefront theme already active."
fi

# Configure WooCommerce store settings to skip setup wizard
if [ -n "${WOOCOMMERCE_STORE_COUNTRY}" ]; then
  echo "Configuring WooCommerce store settings..."
  
  # Set store address settings
  wp option update woocommerce_default_country "${WOOCOMMERCE_STORE_COUNTRY}" --allow-root
  
  # Set currency
  if [ -n "${WOOCOMMERCE_CURRENCY}" ]; then
    wp option update woocommerce_currency "${WOOCOMMERCE_CURRENCY}" --allow-root
  fi
  
  # Mark setup wizard as completed
  wp option update woocommerce_onboarding_profile '{"completed":true}' --format=json --allow-root
  wp option update woocommerce_task_list_complete 1 --allow-root
  
  echo "WooCommerce setup wizard disabled!"
fi

# Install and activate wc-smooth-generator plugin if not already active
if ! wp plugin is-active wc-smooth-generator --allow-root 2>/dev/null; then
  if ! wp plugin is-installed wc-smooth-generator --allow-root 2>/dev/null; then
    echo "Installing wc-smooth-generator plugin from GitHub..."
    wp plugin install https://github.com/woocommerce/wc-smooth-generator/releases/latest/download/wc-smooth-generator.zip --allow-root
  fi
  echo "Activating wc-smooth-generator plugin..."
  wp plugin activate wc-smooth-generator --allow-root
fi

# Generate fake WooCommerce data if enabled
if [ "${WOOCOMMERCE_GENERATE_DATA}" = "true" ]; then
  # Only generate if products don't exist yet
  PRODUCT_COUNT=$(wp post list --post_type=product --format=count --allow-root 2>/dev/null || echo "0")
  if [ "$PRODUCT_COUNT" -eq "0" ]; then
    echo "Generating fake WooCommerce data..."
    
    # Generate hierarchical product categories
    wp wc generate terms product_cat 50 --max-depth=3 --allow-root
    
    # Generate products (simple and variable)
    echo "Generating 50 products..."
    wp wc generate products 50 --use-existing-terms --allow-root
    
    # Generate customers
    echo "Generating 20 customers..."
    wp wc generate customers 20 --allow-root
    
    # Generate orders
    echo "Generating 30 orders..."
    wp wc generate orders 30 --allow-root
    
    echo "Fake data generation complete!"
  else
    echo "Products already exist ($PRODUCT_COUNT found), skipping data generation."
  fi
else
  echo "Fake data generation disabled (WOOCOMMERCE_GENERATE_DATA != true)."
fi

echo "WordPress setup complete!"
