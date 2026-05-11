# AWS S3


## What is AWS S3?

- simple storage service
- used to store and retrieve any amount of data anywhere you are connected to the internet
- easy to configure to host a static website on the cloud
- provides built- in redundancy
  - minimum of 3 availability zones
  - a copy of the data is in a minimum of 3 availabilty zones in the region
  - cna change tier for different regions
- can be accesed from aws console and aws cli
- Similar to Azure blob storage

## How data is stored on S3?

- Stored as objects (files) 
- Objects live inside buckets (folders)
- Access them using web requests

## learning s3 on aws

### setting up the instance
- using ubuntu v 22.04
- security group has ssh open
- run the update and upgrade xommand

### installing python and aws
- `python3 --version` : check version of python installed
- if not installed : `sudo apt-get install python3-pip -y`
- aws version : `aws --version`
- instal awsc cli : 'sudo pip instal awscli'
- configure your access : 'aws congiure'
  - enter your access ID
  - enter your private access ID
  - enter region name: eu-west-1
  - enter default output format: json
### if the above command does not work
1. Download the installer
- curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
1. Unzip it (you might need to install 'unzip' first)
- sudo apt install unzip -y
- unzip awscliv2.zip
1. Run the install scriptsudo 
- sudo ./aws/install

### moving and creating files/ buckets in s3
- access something on s3, show the s3 buckets : 'aws s3 ls'
- command guide : 'aws s3 help'
- make a bucket : 'aws s3 mb s3://tech603-edward-first-bucket' 
- make a file : 'echo this is the first line in a test file > test.txt'
- make a copy and move it to the bucket : 'aws s3 cp test.txt s3://tech603-edward-first-bucket' 
- list files in a bucket : 'aws s3 ls s3://tech603-edward-first-bucket'
- mkdir download and cd into it
  - download files from bucket : 'aws s3 sync s3://tech603-edward-first-bucket .'

### deleting files and buckets
- remove a single file from bucket : 'aws s3 rm s3://tech603-edward-first-bucket/test.txt'
- remove all the files from the bucket : 'aws s3 rm s3://tech603-edward-first-bucket --recursive'
- more specific help : 'aws s3 rm help'
- remove bucket with files in it : 'aws s3 rb s3://tech603-edward-first-bucket/test.txt --force'

### where to find buckets on aws
- search for s3 in search bar
- search your specific name once in s3 interface

## using boto3 in aws s3

- what is boto3
  - allows you to directly create, update, and delete AWS resources from your Python scripts.
- create python scripts in your home folder to run
- install boto3 : 'sudo apt install python3-pip -y'
  
1. list buckets using boto3

- boto.client : tells boto3 what aws service to talk to, which api service to use
  - also creates an object connection, holds credentials, regions to aws. 
```python
import boto3

s3 = boto3.client("s3", region_name="eu-west-1")

response = s3.list_buckets()

for bucket in response["Buckets"]:
  print(bucket["Name"], bucket["CreationDate"])
```
2. create a bucket using boto3

```python
import boto3

s3 = boto3.client("s3", region_name="eu-west-2")

s3.create_bucket(
    Bucket="tech603-edward-test-boto3",
    CreateBucketConfiguration={"LocationConstraint": "eu-west-2"}
)
```

3. upload data/file to S3 bucket

```python
import boto3

s3 = boto3.client("s3", region_name="eu-west-1")

s3.upload_file(
    Filename="./local/path/myfile.txt",
    Bucket="my-bucket",
    Key="folder/myfile.txt"    
)
```

4. download files to a bucket

```python

import boto3

s3 = boto3.client("s3", region_name="eu-west-1")

s3.download_file(
    Filename="test1.txt",
    Bucket="tech603-edward-test-boto3",
    Key="test1.txt"
)
```

5. delete a file

```python
import boto3

s3 = boto3.client("s3", region_name="eu-west-2")

s3.delete_object(Bucket="tech603-edward-test-boto3", Key="test1.txt")

print("File deleted successfully")
```

6. delete a bucket
```python
import boto3

s3_client = boto3.client("s3", region_name="eu-west-2")
s3_resource = boto3.resource("s3", region_name="eu-west-2")

# Step 1 - empty the bucket first
bucket = s3_resource.Bucket("tech603-edward-test-boto3")
bucket.objects.all().delete()

# Step 2 - delete the bucket
bucket.delete()

print("Bucket deleted successfully")
```






