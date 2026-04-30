#!/bin/bash

# purpose: provision mongo db v8.2.5 for sparta tic tac toe application
# testing on: aws, ubuntu 240.04 lts
# planning for it to work on: new vm and run it multiple times
# tested by: edward
# tested when: 30/4/26

echo do update
sudo apt-get update
echo done!
echo

echo upgrade
sudo apt-get upgrade -y
echo done
echo

echo install mongodb GPG key
curl -fsSL https://pgp.mongodb.com/server-8.0.asc | sudo gpg --dearmor -o /usr/share/keyrings/mongodb-server-8.0.gpg
echo done!
echo

#was 8.2
echo create mongodb list file
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
echo done
echo

echo update
sudo apt-get update
echo done
echo

# go to specfific release for certain version of mongodb you want
echo install mongodb
sudo apt-get install -y mongodb-org=8.2.5 mongodb-org-database=8.2.5 mongodb-org-server=8.2.5 mongodb-mongosh mongodb-org-mongos=8.2.5 mongodb-org-tools=8.2.5
echo done
echo

# configure bindIP to 0.0.0.0
echo changing configuration

# configure bind IP



echo start mongodb
sudo systemctl start mongod
echo done

echo enable mongodb to start on boot
sudo systemctl enable mongod
echo done
echo

echo chaning bindIP 
sudo sed -i 's/^ *bindIp: .*/  bindIp: 0.0.0.0/' /etc/mongod.conf
echo done
echo

echo restarting mongod
sudo systemctl restart mongod
echo done
echo


# check status and activate server
# systemctl status mongod
# sudo systemctl start mongod
# systemctl status mongod

sudo nano /etc/mongod.conf
# change the ip to 0.0.0.0
