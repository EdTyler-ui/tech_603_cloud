# running an app in aws

## getting started


- 'sudo apt-get update' : refreshes the list of available packages and there versions. 
- 'sudo apt-get upgrade -y' : updates all packages to there latest versions, -y automatically says yes if prompted

## nginx
- what is it
  - it is a high performance web server and reverse proxy
  - load balancing traffic and caching
- useful commands
  - 'sudo apt install nginx -y' : install nginx
  - 'sudo apt enable nginx' : enables nginx to run when vm is rebooted (usually default)
  - 'sudo systemctl restart nginx' : best for when config files have been altered 
  - 'sudo systemctl status nginx' : see the status of nginx
  

## node.js
- what is it
  - allows users to use javascript to write command line tools locally not in web browser
- useful commands
  - 'curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -' : node version manager, lets you change nodes
  - 'sudo apt-get install -y nodejs' : installs node.js
  - 'npm install' : installs packages
  - 'npm start' : runs the package
  - 'npm start &' : runs package in background

## using git on a vm
- 'sudo apt install git -y' : install git to use git commands 
- 'git clone git_repo.git' : clones repo to vm 
- cd tech603-sparta-app/'nodejs20-sparta-tictactoe-v1 (1)'/app : moves into the app folder in the repo

## pm2
- what is it
  - runs node.js apps in the background and restarts if the app crashes
  - lets you use terminal whilst app is runnig
- useful commands
  - 'sudo npm install -g pm2' : installs pm2 globally so it can be used in any folder
  - 'pm2 status' : see if the app is running
  - 'pm2 start npm --name "ttt-app" -- start' : starts the app and names it
  - 'pm2 delete app_name' : deletes the app

## creating a reverse proxy
- [app_rp_pm2.sh](app_rp_pm2.sh) 
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
    - 'sudo systemctl restart nginx' to restart nginx to apply new configs

## running app using userdata 
- what is userdata?
  - script that automatically runs when you load up your vm
  - used for; cloning repo, installing software, startin app
- how to start it
  - go to launch instance
  - go to advanced details
  - paste your script into the userdata block. DO NOT EDIT THE SCRIPT IN THIS BLOCK
  - launch instance and move to root user to view repo
    - sudo su

## running app using custom app image and a bit of user data
- user data = [run_app_only.sh](run_app_only.sh)
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

## loading mongoDB into your vm
- [prov_app.sh](prov_app.sh)
- what is mongoDb?
  - database used to store and manage data
  - flexible, scalable and developer friendly
  - stores in json like files, nosql involved
- how to launch?
  - launch instance
  - select usual settings (ubuntu, key, appropriate name)
  - edit security configurations so ssh is on my ip (better security) and add port 27017
  - provide relevantname secuirty group
- what to do once in vm terminal?
  - UPDATE AND UPGRADE
  - 'curl -fsSL https://pgp.mongodb.com/server-8.0.asc | \sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \ --dearmor' 
      - 'curl fsSL' : verifys that packages from MongoDB are not tampered with
      - 'sudo gpg' : gpg is an encryption tool
      - --dearmor: converts from ASCII to binary
    - create the mongodDB list file, makes a mongdb repo in a file
      - 'echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list'
    - sudo get-apt update to see new libraries available
  - install mongodb
    - 'sudo apt-get install -y mongodb-org=8.2.5 mongodb-org-database=8.2.5 mongodb-org-server=8.2.5 mongodb-mongosh mongodb-org-mongos=8.2.5 mongodb-org-tools=8.2.5'
  - change the configuration to 0.0.0.0
    - sudo sed -i 's/^ *bindIp: .*/  bindIp: 0.0.0.0/' /etc/mongod.conf
  - start the mongodb
    - sudo systemctl start mongod
  - enable mongodb to start on reboot
    - sudo systemctl enable mongod
  - sudo systemctl status mongod
    - displays enabled and running if mongodb is sucessfully installed

- What to run in the app vm?
  - need a env variable to link the mongoDB with our app vm
    - export MONGODB_URI=mongodb://private-ip:27017/tictactoe
    - :27017 is the mongodb port
    - private ip of the mongodb vm


## monolith vs 2-tier architecture

- monolith:
  - one machine and three layers that interact with each other
    - contains user interface 
    - business logic
    - data access layer, interacts with the database
  - pros: simple, lightweight, simpler to deploy (one set of code)
  - cons: single point of failure, not scalable, becomes complex, have to update everything at once
- 2-tier architecture:
  - splits into two layers, two different machines
    - client
    - database
  - pros: solves most disadavantages of monolith
  - cons: more complex, database exposed, tight coupling

## why use?
- no port numbers in url
- better security
- run multiple apps
- so you dont have to type in 3000


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
