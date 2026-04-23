#!/bin/bash 

# purpose install nginx on a fresh VM
# tested on ubuntu 24.04 LTS

# update
sudo apt update

#upgrade
sudo apt upgrade -y

# install nginx
sudo apt install nginx -y
systemctl status nginx # get status of package

# restart nginx - needed to apply changes
sudo systemctl restart nginx

# enable nginx, run it automatically when linux starts up, default is alread enabled
sudo systemctl enable nginx

# check if enabled
sudo apt is-enabled nginx

# stop nginx
sudo systemctl stop nginx

# start nginx 
sudo systemctl start nginx

# give permission to execute a file
chmod -x filename.sh

# run the bash script, errors in script are indicated after running
./filename.sh

