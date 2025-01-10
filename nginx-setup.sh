#!/usr/bin/env bash

# Update system packages
echo "Updating system packages..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install Nginx
echo "Installing Nginx..."
sudo apt-get install -y nginx

# Enable and start Nginx service
echo "Enabling and starting Nginx service..."
sudo systemctl enable nginx
sudo systemctl start nginx

# Allow Nginx through the firewall
echo "Configuring UFW to allow Nginx..."
sudo ufw allow 'Nginx Full'
sudo ufw reload

# Set up a default Nginx configuration
echo "Setting up default Nginx configuration..."
sudo tee /etc/nginx/sites-available/default > /dev/null <<EOL
server {
    listen 80;
    server_name example.com www.example.com;

    root /var/www/html;
    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ /index.php?\$query_string;
    }

    location ~ \.php\$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.2-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    location ~ /\.ht {
        deny all;
    }

    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
}
EOL

# Test and reload Nginx configuration
echo "Testing and reloading Nginx configuration..."
sudo nginx -t && sudo systemctl reload nginx

# Print Nginx status
echo "Nginx installation and setup complete!"
sudo systemctl status nginx --no-pager
