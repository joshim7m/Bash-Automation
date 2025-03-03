#!/usr/bin/env bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Add PHP repository
echo "Adding PHP repository..."
sudo add-apt-repository ppa:ondrej/php -y

# Install PHP 8.2 and necessary extensions
echo "Installing PHP 8.2 and required extensions for Laravel..."
sudo apt-get update -y
sudo apt-get install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-curl php8.2-mbstring php8.2-xml php8.2-bcmath php8.2-zip php8.2-intl unzip curl

# Enable PHP-FPM service
echo "Enabling and starting PHP-FPM service..."
sudo systemctl enable php8.2-fpm
sudo systemctl start php8.2-fpm

# Add MariaDB repository
echo "Adding MariaDB repository..."
sudo apt-get install -y software-properties-common dirmngr
sudo apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] https://mirror1.hs-esslingen.de/mariadb/repo/10.6/ubuntu focal main'

# Install MariaDB
echo "Installing MariaDB..."
sudo apt-get update -y
sudo apt-get install -y mariadb-server mariadb-client

# Secure MariaDB installation
echo "Securing MariaDB installation..."
sudo mysql_secure_installation

# Configure Laravel-specific MariaDB settings
echo "Configuring MariaDB for Laravel..."
sudo mysql -e "CREATE USER 'laravel'@'localhost' IDENTIFIED BY 'password';"
sudo mysql -e "CREATE DATABASE laravel CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
sudo mysql -e "GRANT ALL PRIVILEGES ON laravel.* TO 'laravel'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

# Install Composer
echo "Installing Composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Verify installations
echo "Verifying installations..."
php -v
mysql --version
composer --version

echo "Setup complete!"
echo "PHP 8.2, MariaDB, and all Laravel dependencies have been installed."
echo "MariaDB Database: 'laravel', User: 'laravel', Password: 'password'"



