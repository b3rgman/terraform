
/*********************************************************************************************************************
Input Variables
*********************************************************************************************************************/

variable "home_sg" {
  type = list
}

variable "vpc" {
  type = string
}

variable "ec2_ssh_key" {
  type = string
}


/*********************************************************************************************************************
EC2 Host
*********************************************************************************************************************/

resource "aws_key_pair" "jb_key" {
  key_name = "jb_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDEButKioQJ3iNbwZYZ4lYh0+/qLTsn2ShIq6TRWkX82cLG7Qd9rcmlRGmlsBwK9bMVKFp2v5/otZgGdkwJMd48NS3ZoEaZeJ/5/kq71eoQG+dZ5bqHdAjeFGMHJ7sdICc2rnUsI9YhsGWV9DVM9T0u5eqtYrlGSB2DEzv/KqsKMG1A80Ho+2SAfpCq8e9YO8LRzwD5FDBJnSN6HxnBWBdQ7WHN2AkWM9JYak9lldsyn8p7nsPY+naNKDGE4UYOM1YpqG6N9uMeivJ9SJTWhQWZMwSP6bzgjebWLWmR1TGTGDe7WQ9CAguS8mI3OWOLDoE9S3e+aHcMdwLApgr5oSA3QCmt2lSAKVXfvtEjeoRkbfXZsr6b5fcCXYtF+Cac9IYCyQjjamSNTV3bD+heMXrrLNbz2+AFb/vDYqJ3Yin2gL8cO2WvXGQFMP6KemWwWrZSs2ILCieJN0465c6dcqWmcNrLf32YEL3aMBZdMG+Y0xish1tc3cLOUWFOSpT+I7M= josh.bergman@ip-172-31-246-248.ec2.internal"
}


resource "aws_instance" "server" {
  ami = "ami-0dc2d3e4c0f9ebd18"
  instance_type = "t2.micro"
  key_name = "aws_key_pair.jb_key.key_name"
  vpc_security_group_ids = var.home_sg

  tags = {
    Name = "Josh Test Server"
  }
}