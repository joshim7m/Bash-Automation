#!/usr/bin/env bash

# Update package list
echo "Updating package list..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Node.js versions to choose from
node_versions=( 18 20 ) # Update the versions as needed
echo "Select the Node.js version you want to install:"

# Display choices and get user input
select node_version in "${node_versions[@]}"; do
    echo "You have chosen Node.js version $node_version"
    break
done

# Add the NodeSource GPG key
echo "Adding NodeSource GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Create NodeSource repository entry
echo "Setting up NodeSource repository for Node.js $node_version.x..."
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$node_version.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Update package list and install Node.js
echo "Installing Node.js $node_version..."
sudo apt-get update
sudo apt-get install -y nodejs

# Verify installation
echo "Installation complete!"
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"
