# SSH into the VM

## After creating VM
- Click on instance ID to go to summary
- Press connect

## locate ssh folder containing private key
- open terminal
- locate .ssh folder using cd command
  - If necessary, run chmod 400 "tech603-name-aws-key.pem", so key is not publicly viewable
  - Check if key is read only using command ls -l
  - only 1 r should be present

## Connecting to vm
- use comand ssh -i "keyfile-user-aws-key.pem" ubuntu@ec2-(ip address).region.compute.amazonaws.com
- copy from the connect page for individual command
- Select yes when prompted if "you are happy to connect"

## Stopping instance 
- Before stopping instance, log out in terminal using command 'exit'
- In instance summary
- Drop down menu in label instance state
- click stop instance

## Reconnecting
- Run the first connecting command but with the changed ip address found under Public IPv4 address
- Press connect and copy the example command with the updated ip address