# running an app in aws

## getting started


- 'sudo apt-get update' : refreshes the list of available packages and there versions. 
- 'sudo apt-get upgrade -y' : updates all packages to there latest versions, -y automatically says yes if prompted
- 

## running app in the background

## running app using pm2
- what is pm2?
- 

## creating a reverse proxy
- what is a reverse proxy?
  - app runs on port 3000, nginx runs on 80, nginx redirects to port 3000, security group is separate entity
  - infront of app and forwards incoming requests
- user -> http://your-ip -> nginx -> app on port 3000
1. manual configuration: (best practice to cp the config file)
    - go to /etc/nginx/sites-available/default
    - find the location block, input
      - 'proxy_pass http://localhost:3000;'
      - 'sudo nginx -t' : tests to see if it ran
      - 'sudo systemctl restart nginx' : restarts nginx to apply changes to config
2. automated configuration:
    - using 'sed' command
    - after installing nginx in bash script
      - sudo sed -i 's|try_files $uri $uri/ =404;|proxy_pass http://localhost:3000;|' /etc/nginx/sites-available/default
        - '-i' : saves the changes to the file
        - substitute| text to replace | text to replace with
        - end with the file path being changed

## running app using userdata 
- what is userdata?
  - script that automatically runs when you load up your vm
  - used for; cloning repo, installing software, startin app
- how to start it
  - go to launch instance
  - go to advanced details
  - paste your script into the userdata block. DO NOT EDIT THE SCRIPT IN THIS BLOCK
  - launch instance and move to root user to view repo

## running app using custom app image and a bit of user data
- what is an image?
  - a snapshot that includes
    - an operating system
    - installed software
    - configuration setting
    - files and folders used
- why do we use images?
  - no installation needed
    - dependencies and env variables already set up
    - no need to build machine from scratch
  - less debugging
  - pre- configured environment
- once you have a bash script that runs the app in the background using pm2, on a reverse proxy and uses userdata. create an image of it
  - go to instance and select your vm you want to create the image in
  - then to action, image and templates, create an image
  - give image a name, create image
- setting up a vm using an image
  - launch an instance with the usual settings but
  - in application, choose my AMI and find your image
  - in advanced details and the userdata section add:
    - have !#/bin/bash
    - a cd into the app that you want to run
      - cd tech603-sparta-app/'nodejs20-sparta-tictactoe-v1 (1)'/app
    - and the pm2 start code
      - sudo pm2 start npm --name "ttt-app" -- start
  - launch instance but change 
    - root@public_id to ubuntu@public_id
- terminate vm that you got the snapshot from if no longer needed

## pm2 codes to rememver
- pm2 start --name
- pm2 stop my-app
- pm2 delete my-app
- pm2 status
- pm2 save


## why use?
- no port numbers in url
- better security
- run multiple apps
- so you dont have to type in 3000


## using userdata + pros and cons

# Runbook for tic tac toe sparta app

## manual deployment

## deployment with bash scripts

## what to expect when running user data on a app VM
- an error if theres nothing to connect to
- Nginx home page eventually loads
- 502 error: bad gateway
- app display

# developing higher levels of automation with app deployment on vms
- lowest level of automation + slowest way to run app
  - stage 1: manual deployment, ssh in first
- low level of automation + slow way to run app
  - use bash script, ssh in
- medium level of automation + medium speed to run app
  - user data, run without having to log in, no ssh
- high level of automation + fast speed to run app
  - using image and a little bit of user data, image is a selection of files and folders used to run the app
  - make copy of your vm so you can use in the future