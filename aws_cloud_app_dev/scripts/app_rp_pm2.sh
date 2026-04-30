#!/bin/bash

echo do update
sudo apt-get update
echo done!
echo

echo upgrade
sudo apt-get upgrade -y
echo done
echo

# install nginx
sudo apt install nginx -y
echo done
echo

sudo sed -i 's|try_files $uri $uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
sudo nginx -t
sudo systemctl restart nginx

# setup script for nodejs
echo run setup script for nodejs
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
echo done
echo

echo install nodejs
sudo apt-get install -y nodejs
echo done
echo

# installing git to vm
echo installing git
sudo apt install git -y 

# cloning repo
echo cloning repo
git clone https://github.com/EdTyler-ui/tech603-sparta-app.git 
echo done
echo

# change into app folder
echo moving to app folder
cd tech603-sparta-app/'nodejs20-sparta-tictactoe-v1 (1)'/app
echo done
echo

# installing pm2
echo installing pm2
sudo npm install -g pm2
echo
# comment this out if you do not need to connect to database
export MONGODB_URI=mongodb://172.31.18.164:27017/tictactoe

# installing app and pm2
echo installing app
npm install
echo starting app, run in background
pm2 start npm --name "ttt-app" -- start

