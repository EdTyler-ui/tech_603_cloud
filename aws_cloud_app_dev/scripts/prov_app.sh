#!/bin/bash
 
# Purpose: Provision Mongo DB v8.2.5 for Sparta Tic Tac Toe application
# Testing on: AWS, Ubuntu 24.04 LTS
# Planning for it to work on: New VM and run it multiple times
# Tested by: Edward
# Tested when: 30/4/26
 
echo update...
sudo apt-get update
echo done!
echo
 
echo upgrade...
sudo apt-get upgrade -y
echo done!
echo
 
echo install MongoDB GPG key...
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
   --dearmor
echo done!
echo
 
echo create MongoDB list file...
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.2.list
echo done!
echo
 
echo update...
sudo apt-get update
echo done!
echo
 
echo install MongoDB...
sudo apt-get install -y mongodb-org=8.2.5 mongodb-org-database=8.2.5 mongodb-org-server=8.2.5 mongodb-mongosh mongodb-org-mongos=8.2.5 mongodb-org-tools=8.2.5
echo done!
echo

echo changing bindIP 
sudo sed -i 's/^ *bindIp: .*/  bindIp: 0.0.0.0/' /etc/mongod.conf
echo done
echo
 
# configure bind IP
 
echo start mongodb...
sudo systemctl start mongod
echo done!
echo
 
echo enable mongodb to start on boot...
sudo systemctl enable mongod
echo done!
echo

echo restart mongodb
sudo systemctl restart mongod
echo done
 
export MONGODB_URI=mongodb://172.31.24.17:27017/tictactoe
 