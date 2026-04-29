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

# installing app 
echo installing app
npm install
echo starting app, run in background
npm start & # use nohup if you dont want it to hangup after terminating
