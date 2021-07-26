terraform {

}

provider "aws" {
  alias = "main"
  allowed_account_ids = [
  "332501836635",
  ]
  profile = "default"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::332501836635:role/Administrator"
    session_name = "Terraform Administrator"
  }
}

// Input Variables
//*********************************************************************************************************************
variable "vpc" {
  type = string
  default = "vpc-55c5a428"
}

variable "ami" {
  type = string
  default = "ami-0dc2d3e4c0f9ebd18"
}

variable "security_group" {
  type = string
  default = ""
}

variable "private_subnet" {
  type = string
  default = "subnet-8ede3ac2"
}

//variable "public_subnet" {
//  type = "string"
//  default = ""
//}

variable "ssh_key" {
  type = string
  default = "jb_key"
}

// *********************************************************************************************************************

//Modules
//**********************************************************************************************************************

module "ec2" {
  source = "./modules/ec2"
  ssh_key = module.ec2.ec2_ssh_key
  public_subnet = var.public_subnet
  private_subnet = var.private_subnet
}

module "security" {
  source = "./modules/security"
  vpc = var.vpc
}

module "network" {
  source = "./modules/network"
  ec2_instance = module.ec2.ec2_instance
  vpc = var.vpc
}

//resource "aws_instance" "server" {
//  ami = "ami-0dc2d3e4c0f9ebd18"
//  instance_type = "t2.micro"
//
//  tags =  {
//    Name = "JoshTestServer"
//  }
//}