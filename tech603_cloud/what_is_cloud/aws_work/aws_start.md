# starting with aws

## creating a key- pairs
- Log into aws
  - using the login and pw provided
- go to EC2 and click key pairs
- create key pair and enter group-user-ssh-key with RSA
- create key pair and save the private key in your .ssh file

## creating a virtual machine
- go to EC2 and go to instances and launch instances
- give a name: group-name-vm-first/second/..
- go to ubuntu server 24.04: free and open source, great for servers
- t3.micro: size and power of machine, cheap and free, perfect for learning and testing small projects
- select your key public pair: no password shareed over internet, much ahrder to hack
- use the tech603 security and allow ssh traffic and http traffic
- create instance
- delete instance when done