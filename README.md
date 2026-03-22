# WooCommerce One-Click Install

A one-click WooCommerce deployment with automated setup and optional test data generation optimized for Railway deployment.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/woocommerce?referralCode=b1lqhj)


## Features

- **Zero-Config Deployment** - WordPress and WooCommerce auto-install on first run
- **Test Data Generator** - Optionally create populate your WooCommerce store with test products, customers, and orders on install
- **Smart Defaults** - Skip setup wizards with environment variable configuration, Woocomerce theme installed by default

## What's Included

| Component | Version | Purpose |
|-----------|---------|---------|
| WordPress | Latest | CMS and admin interface |
| WooCommerce | Latest | E-commerce platform |
| WP-CLI | Latest | Command-line management |
| wc-smooth-generator | Latest | Test data generator |
| MariaDB | Latest | Database |

## Prerequisites

- **For local development:** Docker & Docker Compose
- **For Railway deployment:** Railway (sign up at [railway.com](https://railway.com/?referralCode=b1lqhj))

## Local Development

1. **Clone and start:**
   ```bash
   git clone https://github.com/epilocal/woocommerce-oneclick.git
   ```
   Configure environment variables in docker compose (especially passwords!)

   ```bash
   cd woocommerce-oneclick
   docker compose up -d
   ```

2. **Access your store:**
   - Storefront: http://localhost:8080
   - Admin: http://localhost:8080/wp-admin
   - Login with admin username and password configured in docker-compose.yaml

3. **Stop when done:**
   ```bash
   docker compose down
   ```

### Useful Commands

**Stop the containers:**
```bash
docker compose down
```

**Restart the containers:**
```bash
docker compose restart
```

**View logs:**
```bash
docker compose logs -f wordpress  # WordPress logs
docker compose logs -f db         # Database logs
```

**Rebuild after Dockerfile changes:**
```bash
docker compose down
docker compose build --no-cache
docker compose up -d
```

## Production Deployment on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/woocommerce?referralCode=b1lqhj)

**One-Click Deploy:**
1. Click "Deploy on Railway" above
2. **Important:** Set admin credentials in Railway dashboard (Variables tab):
   - `WORDPRESS_ADMIN_USER` - Choose a unique username (not "admin")
   - `WORDPRESS_ADMIN_PASSWORD` - Strong password
   - `WORDPRESS_ADMIN_EMAIL` - Your email address
   - Railway encrypts all environment variables
3. Optionally configure WooCommerce store settings
4. Wait 2-3 minutes for deployment
5. Access your store at the Railway-provided URL

No server setup, database configuration or volume management required. For further details, you can refer to the step-by-step guide: [How to Deploy WooCommerce on Railway](https://blog.epilocal.com/developers/deploy-woocommerce-on-railway/).


## Production Deployment on Other Platforms

This container works on any platform supporting Docker, MySQL, and persistent volumes.

**For custom deployments:**
1. Push this repo to GitHub
2. Connect to your platform
3. Add MySQL database
4. Add persistent volume at `/var/www/html`
5. Configure environment variables
6. Deploy!

## WooCommerce Configuration

The following environment variables can optionally be configured to skip the WooCommerce set-up wizard and enable test data generation on install. If you configure a country and currency, the test data will be localized accordingly.

| Variable | Default | Description |
|----------|---------|-------------|
| `WOOCOMMERCE_STORE_COUNTRY` | `US:NJ` | Store location (format: `COUNTRY_CODE` or for US `US:STATE`) |
| `WOOCOMMERCE_CURRENCY` | `USD` | Store currency code |
| `WOOCOMMERCE_GENERATE_DATA` | `true` | Generate test data on install |

**Country Code Examples:**
- `US:CA` - California, USA
- `US:NY` - New York, USA
- `GB` - United Kingdom
- `AU` - Australia
- `DE` - Germany
- `FR` - France

**Currency Code Examples:**
- `USD` - US Dollar
- `EUR` - Euro
- `GBP` - British Pound
- `CAD` - Canadian Dollar
- `AUD` - Australian Dollar

### Test Data Generation

When `WOOCOMMERCE_GENERATE_DATA=true`, the setup script creates:

- **50 products** - Mix of simple and variable products with categories
- **50 product categories** - Hierarchical structure (up to 3 levels deep)
- **20 customers** - Realistic names and addresses
- **30 orders** - Various statuses (completed, processing, pending)

**To disable test data:** Set `WOOCOMMERCE_GENERATE_DATA=false` before first deployment.


## Production Considerations

1. **Change default passwords** - Update `WORDPRESS_ADMIN_PASSWORD` to a strong password
2. **Use environment secrets** - Store credentials in Railway/platform secret management
3. **Disable test data** - Set `WOOCOMMERCE_GENERATE_DATA=false`
4. **Enable HTTPS** - Railway provides this automatically
5. **Keep updated** - Regularly update WordPress, WooCommerce, and plugins
6. **Set up backups** - Configure automated database backups (Railway Pro includes this)
7. **Use strong database password** - Change `WORDPRESS_DB_PASSWORD` from default

## Tech Stack

- [WordPress](https://wordpress.org/) - Content management system
- [WooCommerce](https://woocommerce.com/) - E-commerce platform
- [MariaDB](https://mariadb.org/) - Database engine
- [WP-CLI](https://wp-cli.org/) - Command-line interface
- [WC Smooth Generator](https://github.com/woocommerce/wc-smooth-generator) - Test data generator
- [Docker](https://www.docker.com/) - Container platform

## License

MIT License