# Deploy and Host WooCommerce on Railway

A one-click WooCommerce deployment with automated setup, optional test data generation, and persistent storage. This template includes WordPress, WooCommerce, WP-CLI, and the wc-smooth-generator plugin for creating realistic product data.

## About Hosting WooCommerce on Railway

This template deploys a complete WooCommerce stack: a MySQL database, WordPress with WooCommerce pre-installed, and automated configuration. WordPress auto-installs on first deployment with WooCommerce activated and ready to use. The included wc-smooth-generator plugin can optionally create realistic test products, customers, and orders for development and demo purposes. Environment variables can be pre-configured to connect the database and skip manual setup wizards.

## Common Use Cases

- E-commerce stores needing a fast, managed WooCommerce hosting solution
- Development and staging environments with automated test data
- WooCommerce headless backends for modern frontends (Next.js, React, etc.)
- Agencies deploying client stores with pre-configured settings
- Learning WooCommerce development with realistic product catalogs

## Dependencies for WooCommerce Hosting

- MySQL 8.0+ (included in template)
- Docker runtime (provided by Railway)

### Deployment Dependencies
- [WordPress Official Docker Image](https://hub.docker.com/_/wordpress)
- [WooCommerce Plugin](https://woocommerce.com/)
- [WC Smooth Generator](https://github.com/woocommerce/wc-smooth-generator)
- [WooCommerce Storefront Theme](https://github.com/woocommerce/storefront)
- [MariaDB](https://mariadb.org/)

### Implementation Details

After deployment, WordPress and WooCommerce auto-install based on the minimal configuration steps below. The database and persistent volume are automatically provisioned.

**Configuring WordPress**
You must set these required environment variables in Railway when deploying:
   - `WORDPRESS_ADMIN_USER` - Admin username (avoid "admin" for security)
   - `WORDPRESS_ADMIN_PASSWORD` - Your secure admin password (make it secure)
   - `WORDPRESS_ADMIN_EMAIL` - Your admin email address

**Configuring WooCommerce (Optional)**
You can optionally pre-configure WooCommerce with these environment variables:
- `WOOCOMMERCE_STORE_COUNTRY` - Store location (format: `US:CA` for California, `GB` for UK)
- `WOOCOMMERCE_CURRENCY` - Store currency (`USD`, `EUR`, `GBP`, etc.)
- `WOOCOMMERCE_GENERATE_DATA` - Set to `true` to generate test product, customer and order data

If these options are not provided, you can manually configure your WooCommerce store later and add test data through the WC Smooth Generator Plugin interface.

**Deployment**
1. Wait for the initial deployment to complete (usually 2-3 minutes)
2. Visit your site URL provided by Railway
3. Log in to WordPress admin at `https://your-domain/wp-admin` with credentials set above
4. WooCommerce will be pre-configured based on your environment variables
5. If `WOOCOMMERCE_GENERATE_DATA=true`, test products and orders will be created automatically

For further details, you can refer to the step-by-step guide: [How to Deploy WooCommerce on Railway](https://blog.epilocal.com/developers/deploy-woocommerce-on-railway/).


## Why Deploy WooCommerce on Railway?
Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying WooCommerce on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
