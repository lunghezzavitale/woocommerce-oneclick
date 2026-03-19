# Deploy and Host WooCommerce on Railway

A one-click WooCommerce deployment with automated setup, optional test data generation, and persistent storage. This template includes WordPress, WooCommerce, WP-CLI, and the wc-smooth-generator plugin for creating realistic product data.

## About Hosting WooCommerce on Railway

This template deploys a complete WooCommerce stack: a MySQL database, WordPress with WooCommerce pre-installed, and automated configuration. WordPress auto-installs on first deployment with WooCommerce activated and ready to use. The included wc-smooth-generator plugin can optionally create realistic test products, customers, and orders for development and demo purposes. Environment variables are pre-configured to connect the database and skip manual setup wizards.

## Common Use Cases

- E-commerce stores needing a fast, managed WordPress hosting solution
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

### Implementation Details

After deployment, WordPress and WooCommerce auto-install with no manual configuration required. The database and persistent volume are automatically provisioned.

**Post-Deployment Setup:**

1. Wait for the initial deployment to complete (usually 2-3 minutes)
2. Visit your site URL provided by Railway
3. Log in to WordPress admin at `https://your-domain/wp-admin` with:
   ```
   Username: Set via WORDPRESS_ADMIN_USER (default: admin)
   Password: Set via WORDPRESS_ADMIN_PASSWORD (change this!)
   ```
4. WooCommerce will be pre-configured based on your environment variables
5. If `WOOCOMMERCE_GENERATE_DATA=true`, test products and orders will be created automatically

**Configuring WooCommerce:**

The template pre-configures WooCommerce with these environment variables:

- `WOOCOMMERCE_STORE_COUNTRY` - Store location (format: `US:CA` for California, `GB` for UK)
- `WOOCOMMERCE_CURRENCY` - Store currency (`USD`, `EUR`, `GBP`, etc.)
- `WOOCOMMERCE_GENERATE_DATA` - Set to `true` to generate test product, customer and order data

**Persistent Storage:**

The template includes a volume mounted at `/var/www/html` to persist:
- WordPress core files
- Uploaded media and product images
- Plugin installations
- Theme files
- WooCommerce data

This ensures your content survives deployments and restarts.

**Payment Configuration:**

After deployment, configure payment gateways in WooCommerce:
1. Go to **WooCommerce → Settings → Payments**
2. Enable and configure your payment processor (Stripe, PayPal, etc.)
3. Add API keys from your payment provider

**For Headless/API Usage:**

If using WooCommerce as a headless backend:
1. Go to **WooCommerce → Settings → Advanced → REST API**
2. Create API keys with Read/Write permissions
3. Use these keys in your frontend application (Next.js, React, etc.)

**Important Production Considerations:**

1. **Change default passwords** - Update `WORDPRESS_ADMIN_PASSWORD` before deployment
2. **Disable test data** - Make sure that `WOOCOMMERCE_GENERATE_DATA=false` for production
3. **Configure backups** - Railway Pro includes automatic database backups
4. **SSL/HTTPS** - Railway provides automatic HTTPS for all deployments
5. **Updates** - Use WP-CLI or WordPress admin to keep plugins updated


## Why Deploy WooCommerce on Railway?

Railway simplifies WooCommerce hosting by eliminating infrastructure complexity. Deploy a complete e-commerce stack with one click—no server configuration, no database setup, no volume management. Railway handles provisioning, scaling, and networking automatically while you focus on building your store.

This template gives you a production-ready WooCommerce installation in minutes instead of hours. Automatic HTTPS, persistent storage, and database backups are included. Whether you're running a storefront, building a headless commerce backend, or creating demo environments with test data, Railway provides the infrastructure so you can focus on your products and customers.
