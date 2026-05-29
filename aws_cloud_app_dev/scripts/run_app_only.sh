#!/bin/bash

cd /
mkdir repo
cd repo


cd tech603-sparta-app/app

export MONGODB_URI=mongodb://private_ip:27017/tictactoe

node seeds/seed.js

npm install

pm2 start index.js

