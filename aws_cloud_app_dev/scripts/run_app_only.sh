#!/bin/bash

cd /
mkdir repo
cd repo


cd tech603-sparta-app/app


echo "Starting application with PM2..."
pm2 start npm --name sparta-app -- start

