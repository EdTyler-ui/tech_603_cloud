#!/bin/bash
 

echo "Starting script.."
echo "Author: Edward"
echo "Purpose: Deploy our TTT web-app on a fresh VM"
echo "Tested on: Ubuntu 24.04 LTS"
echo
 
# making repo folder
cd /
mkdir repo
cd repo
 
# Update package list
echo "Updating package lists..."
sudo apt-get update
 
# Upgrade packages
echo "Upgrading installed packages..."
sudo apt-get upgrade -y
 
# Install Nginx
echo "Installing Nginx..."
sudo apt install nginx -y
 
# Replace the default static file handling rule with a reverse proxy rule
sudo sed -i 's|try_files $uri $uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
 
# This basically does a check wether the default file contains vald syntax before even starting the server
sudo nginx -t
 
# Restart Nginx (apply any changes)
echo "Restarting Nginx service..."
sudo systemctl restart nginx
 
# Enable Nginx at boot ---> Default is ALREADY enabled
echo "Enabling Nginx to start on boot..."
sudo systemctl enable nginx
 
# Check status
echo "Checking Nginx service status..."
sudo systemctl is-active nginx
 
# Install Node.js 20 (adds NodeSource repo and installs Node.js)
echo "Setting up Node.js 20 repository and installing Node.js..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

echo "installing nodejs" 
sudo apt-get install -y nodejs
 
echo "Cloning from repo..."
git clone https://github.com/EdTyler-ui/tech603-sparta-app.git
 
# Show repository contents to confirm successful clone
echo "Listing project contents:"
ls
 
# Confirm current working directory before moving
echo "Current directory:"
pwd
 
# Move into the application directory
echo "Changing directory to application folder:"
cd tech603-sparta-app/app
pwd
 
echo "Installing dependencies..."
sudo npm install -g pm2
 
npm install
echo "Stopping existing app if running..."
pm2 delete sparta-app
 
echo "Starting application with PM2..."
pm2 start npm --name sparta-app -- start
 
