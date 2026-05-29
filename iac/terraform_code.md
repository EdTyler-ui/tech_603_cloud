
## creating the terraform repo

1. go into tech603-terraform folder
2. intialise the repo : 'git init'
3. currently tf.state files are included in git push
4. use code to create .gitignore file in code
  - 'curl -s https://raw.githubusercontent.com/github/gitignore/main/Terraform.gitignore -o .gitignore'
5. open .gitignore file now present in folder (use 'ls -a' to see)
  - file contains .tfstate files already set 
  - also add 'variable.tf' for later use
6. renamine your branch : 'git branch -M main'
7. add the new repo : 'git remote add origin https://github.com/EdTyler-ui/tech603-terraform.git'
8. add all the changes to staging : 'git add .'
9. commit the changes : 'git commit -m 'terraform work'
10. push them to your new repo : 'git push -u origin main'


## creating a security group
- create a security group that controls inbound and outbound traffic for instances
- ssh from machine and allow public access from web and application ports

### configuration details
```resource "aws_security_port" "allow ports" {
    name        = "tech603-edward-tf-allow-port-22-3000-80"
    description = "Allow SSH from my IP, ports 3000 and 80 from all"    
}
  ```
### ingress rules
| Port | Protocol | Source           | Purpose                     |
| ---- | -------- | ---------------- | --------------------------- |
| 22   | TCP      | 86.140.179.27/32 | Secure Shell (SSH) access   |
| 3000 | TCP      | 0.0.0.0/0        | Application access (public) |
| 80   | TCP      | 0.0.0.0/0        | HTTP web traffic (public)   |

### egress rules
| Port Range | Protocol | Destination | Purpose            |
| ---------- | -------- | ----------- | ------------------ |
| All        | All      | 0.0.0.0/0   | Allow all outbound |

### add your key and this security group to the main.tf
- 'key_name = "tech603-edward-aws-key"'
- 'vpc_security_group_ids = [aws_security_group.allow_ports.id]'
  - this is the name of the security group you have created in security_group.tf 
  - key name is just the key you have been using for aws instances

### generating a public ip
1. create data source that uses a default vpc 
```
data "aws_vpc" "default" {
  default = true
}
``` 
2. then find the subnets from that vpc
```
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
``` 
3. chooses the first option from the list of subnets made in step 2
```
data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}
```
4. then add `subnet_id = data.aws_subnet.default.id` to the resouce instance aws in main.tf


### adding variables
- create *variables.tf* script
- use instead of manualling adding variables to each code block
- example:
```
variable "instance_type_ami" "default" {
  instance_type = "t3.micro"
  description = "the ami id for my ttt app 24.04"
}
```
- then add instance_type = var.instance_type_ami to main.tf


### adding user data and my own ami
1. create user_data_app.sh.tpl -> add userdata for ttt app
- do not use .sh script as it is static file and private ip needs constant altering for db
2. change default in ubuntu_ami_id variable to your ami id ("ami-0450778f4fa15a836")
3. add `user_data = file("user_data.sh")` to the main.tf aws resource 
4. terraform apply and run the app


### configuring with database ami
1. create `resource "aws_instance" "test_instance_db"` which will contain:
  - `ami = "ami-07e7962d69d0f2eb4"` : the database ami id
  - `instance_type = var.instance_type_ami` : the same instance type as the app vm
  - `key_name = var.aws_key` 
  - `tags = {"Name" = "tech603-edward-tf-test-instance_db" }` : give the new db instance a name
2. db security configurations, create new file *db_sg.tf*
- `resource "aws_security_group" "allow_ports_db"` : give instance a name
- ingress block for ssh port:
```
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["86.140.179.27/32"] # my local machines ip (use `curl ifconfig.me` to find)
  }
```
- ingress block for mongodb port:
```
ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
```
- egress block for db instance:
```
# outbound traffic can be for anywhere, protocol -1 means any protocol
egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
```
3. end instance by giving it a tag and add security configs to db instance in mainf.tf
- `vpc_security_group_ids = [aws_security_group.allow_ports_db.id]` 

4. change userdata used in the app instance
- in the user_data_app.sh.tpl file
  - `export MONGODB_URI=mongodb://${db_private_ip}:27017/tictactoe` : terraform injects private ip of mongodb instance into the command
  - `echo "export MONGODB_URI=mongodb://${db_private_ip}:27017/tictactoe" >> /etc/environment` : helps the variable change survive reboot
  - then add to userdata variable in app instance:
```
user_data = templatefile("user_data_app.sh.tpl", {
    db_private_ip = aws_instance.test_instance_db.private_ip
  })
```

### launch instances with a custom vpc

1. create a custom vpc
- `resource "aws_vpc" "main"` : create the vpc resource
- `cidr_block = "10.0.0.0/16"` : IP address range
- `tags = {Name = "tech603-edward-vpc"}` : give appropriate name

2. add private and public subnets
- `resource "aws_subnet" "private"` : create private resource (replace with public for public subnet)
- `vpc_id            = aws_vpc.main.id` : link to custom vpc created
- `cidr_block        = "10.0.3.0/24"` : IP address range (change to 10.0.2.0/24 for public)
- `availability_zone = "eu-west-1a"`
- `tags = {Name = "tech603-edward-private-subnet"}` : give appropriate name (change to public for public subnet)

3. create internet gateway
- `resource "aws_internet_gateway" "igw"` : create internet gateway resource
- `vpc_id = aws_vpc.main.id` : link to custom vpc
- `tags = {Name = "tech603-edward-igw"}` : give appropriate name

4. create route tables
- `resource "aws_route_table" "public"` : create route table resource
- `vpc_id = aws_vpc.main.id` : link to custom vpc
- link route table to internet gateway
```route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
```  
- `tags = {Name = "tech603-edward-public-rt"}` : give appropriate name

5. associate route table with public subnet
- `resource "aws_route_table_association" "public"` : create association resource
- `subnet_id      = aws_subnet.public.id` : 
- `route_table_id = aws_route_table.public.id` : link route table to public subnet

6. changes to db security group:
- in the port 27017, open to only the app security group
- `security_groups = [aws_security_group.allow_ports.id]` : replace the cidr_blocks = ["0.0.0.0/0"] with this

7. add custom vpc to your security groups
- `vpc_id = aws_vpc.main.id` : insert this in the resource security groups

8. change subnet_id in both db and app instances in main.tf
- `subnet_id = aws_subnet.public.id` : add this to the app vm
- `subnet_id = aws_subnet.private.id` : add this to the db vm

9. hash out the aws_vpc and aws_subnets as custom vpc is now being used 

### creating a github repo using terraform

1. create a main.tf with the following code:
```hcl
# says what provider to use and which version, declaring dependencies
terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }
  }
}

# obtain token from github
provider "github" {
  token = var.github_token
}

# what you want to create
resource "github_repository" "example" {
  name        = "my-terraform-repo"
  description = "Repo created using Terraform"
  visibility  = "private"

  auto_init = true
}
```

2. store your token securely in a variables.tf folder
```hcl
variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}
```
- then set it as an environemntal variable
```bash
export TF_VAR_github_token=your_token_here
```

3. run the terraform commands
- `terraform init`
- `terraform plan`
- `terraform apply`
- and the repo will be created





