terraform {

}

provider "aws" {
  region = "us-east-1"
//  allowed_account_ids = [
//  "332501836635",
//  ]
  profile = "josh.bergman"

//  assume_role {
//    role_arn = "arn:aws:iam::332501836635:role/Administrator"
//    session_name = "Terraform Administrator"
//  }
}
//*********************************************************************************************************************
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

//variable "home_sg" {
//  type = list
//}


variable "ec2_ssh_key" {
  type = string
  default = "jb_key"
}

// *********************************************************************************************************************
//Modules
//**********************************************************************************************************************

module "ec2" {
  source = "./modules/ec2"
  home_sg = [module.security.home_sg]
  ec2_ssh_key = module.ec2.ec2_ssh_key
  vpc = var.vpc
}

module "security" {
  source = "./modules/security"
  vpc = var.vpc
}