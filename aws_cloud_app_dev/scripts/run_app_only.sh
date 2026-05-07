#!/bin/bash

cd /
mkdir repo
cd repo


cd tech603-sparta-app/app

export MONGODB_URI=mongodb://172.31.24.17:27017/tictactoe

node seeds/seed.js

npm install

pm2 start index.js

