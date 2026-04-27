#!/bin/bash

echo do update
sudo apt-get update
echo done!
echo

echo upgrade
sudo apt-get upgrade -y
echo done
echo

echo install nginx..
# nginx will be used later as a reverse proxy to forward requests to the application on port 3000
sudo apt install nginx -y
echo done
echo

# configure our reverse proxy

echo restart nginx
sudo systemctl restart nginx
echo done
echo

echo run setup script for nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
echo done
echo
echo install nodejs
sudo apt-get install -y nodejs
echo done
echo

# get the app


# run the app

# node -v shows version

