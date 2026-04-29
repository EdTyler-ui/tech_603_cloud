#!/bin/bash

echo moving to app folder
cd tech603-sparta-app/'nodejs20-sparta-tictactoe-v1 (1)'/app
echo done
echo

echo starting app, run in background
sudo pm2 start npm --name "ttt-app" -- start